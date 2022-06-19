import os
import datetime
import sys
from urllib.parse import urlparse
from urllib.request import url2pathname
from PySide2 import QtCore, QtWidgets, QtQml
from cryptography.fernet import Fernet

from rule.rule import Rule
from indicator.indicator_parser import ZeekIndicatorParser
from indicator.indicator_analyzer import IndicatorAnalyzer
from analysis.analysis import analyze_file

if "python" in sys.executable:
    os.system("python3 collector.py")

import resources


class Config:
    BUILD = "release"
    VERSION = "1.0.0"


class Application(QtCore.QObject):
    def __init__(self, parent=None):
        super().__init__(parent=parent)
        self._file_content = ""
        self._rule = None
        self._filtered_content = ""
        self._indicator_parser = ZeekIndicatorParser()
        self._indicator_analyzer = IndicatorAnalyzer()
        self._analysis = ""
        self._file_path = ""
        self._encrypt = True
        self._decrypt = True
        self._key = b'lrd6MJaun1NMdbVni9Og-BpRXPMQNnSVaNHv48qn-8M='

    fileContentChanged = QtCore.Signal()
    ruleChanged = QtCore.Signal()
    filteredContentChanged = QtCore.Signal()
    analysisChanged = QtCore.Signal()
    filePathChanged = QtCore.Signal()
    encryptChanged = QtCore.Signal()
    decryptChanged = QtCore.Signal()
    decryptError = QtCore.Signal()

    @QtCore.Slot(str)
    def save_logs_to_file(self, content):
        if self._encrypt:
            content = Fernet(self._key).encrypt(content.encode())
            with open("filtered_logs.log", "wb") as f:
                f.write(content)
        else:
            with open("filtered_logs.log", "w") as f:
                f.write(content)

    def _get_file_content(self):
        return self._file_content

    def _set_file_content(self, file_path):
        self._file_path = file_path
        with open(url2pathname(urlparse(file_path, scheme="file").path), "r") as f:
            if self._decrypt:
                try:
                    self._file_content = Fernet(self._key).decrypt(f.read().encode()).decode()
                except Exception:
                    self.decryptError.emit()
                    return
            else:
                self._file_content = f.read()
        self._analysis = analyze_file(url2pathname(urlparse(self._file_path, scheme="file").path))
        self.fileContentChanged.emit()

    fileContent = QtCore.Property(str, _get_file_content, _set_file_content, notify=fileContentChanged)
    filePath = QtCore.Property(str, lambda self: self._file_path, notify=fileContentChanged)
    analysis = QtCore.Property(str, lambda self: self._analysis, notify=fileContentChanged)

    def _get_rule(self):
        return self._rule is not None

    def _set_rule(self, rule_object):
        rule_dict = QtCore.QJsonValue.toVariant(rule_object)
        after_datetime = None
        if rule_dict.get('after_datetime'):
            after_hour, after_minute = rule_dict.get('after_datetime', {}).get("time").split(":")
            after_day = int(rule_dict.get('after_datetime', {}).get("day"))
            after_month = int(rule_dict.get('after_datetime', {}).get("month"))
            after_year = int(rule_dict.get('after_datetime', {}).get("year"))
            after_datetime = datetime.datetime(after_year, after_month, after_day, int(after_hour), int(after_minute))
        before_datetime = None
        if rule_dict.get('before_datetime'):
            before_hour, before_minute = rule_dict.get('before_datetime', {}).get("time").split(":")
            before_day = int(rule_dict.get('before_datetime', {}).get("day"))
            before_month = int(rule_dict.get('before_datetime', {}).get("month"))
            before_year = int(rule_dict.get('before_datetime', {}).get("year"))
            before_datetime = datetime.datetime(before_year, before_month, before_day, int(before_hour), int(before_minute))
        host_name = rule_dict.get("host_name")
        incoming_interface = rule_dict.get("in")
        outgoing_interface = rule_dict.get("out")
        mac = rule_dict.get("mac")
        src = rule_dict.get("src")
        dst = rule_dict.get("dst")
        min_len = rule_dict.get("min_len")
        max_len = rule_dict.get("max_len")
        tos = rule_dict.get("tos")
        prec = rule_dict.get("prec")
        ttl = rule_dict.get("ttl")
        unique_id = rule_dict.get("id")
        ce = rule_dict.get("ce")
        df = rule_dict.get("df")
        mf = rule_dict.get("mf")
        proto = rule_dict.get("proto")
        spt = rule_dict.get("spt")
        dpt = rule_dict.get("dpt")
        seq = rule_dict.get("seq")
        ack = rule_dict.get("ack")
        window = rule_dict.get("window")
        res = rule_dict.get("res")
        packet_flags = rule_dict.get("packet_flags")
        opt = rule_dict.get("opt")
        self._rule = Rule(
            after_datetime=after_datetime,
            before_datetime=before_datetime,
            host_name=host_name,
            IN=incoming_interface,
            OUT=outgoing_interface,
            MAC=mac,
            SRC=src,
            DST=dst,
            min_len=min_len,
            max_len=max_len,
            TOS=tos,
            PREC=prec,
            TTL=ttl,
            id=unique_id,
            CE=ce,
            DF=df,
            MF=mf,
            PROTO=proto,
            SPT=spt,
            DPT=dpt,
            SEQ=seq,
            ACK=ack,
            WINDOW=window,
            RES=res,
            packet_flags=packet_flags,
            OPT=opt,
        )
        self._filtered_content = ""
        indicators = self._indicator_parser.parse(self._file_content)
        valid_indicators = list(filter(
            lambda indicator: self._indicator_analyzer.indicator_fits_rule(self._rule, indicator), indicators
        ))
        for indicator in valid_indicators:
            self._filtered_content += indicator.string_data + "\n"
        self.ruleChanged.emit()

    rule = QtCore.Property(QtCore.QJsonValue, _get_rule, _set_rule, notify=ruleChanged)

    def _get_encrypt(self):
        return self._encrypt

    def _set_encrypt(self, value):
        self._encrypt = value
        self.encryptChanged.emit()

    encrypt = QtCore.Property(bool, _get_encrypt, _set_encrypt, notify=encryptChanged)

    def _get_decrypt(self):
        return self._decrypt

    def _set_decrypt(self, value):
        self._decrypt = value
        self.decryptChanged.emit()

    decrypt = QtCore.Property(bool, _get_decrypt, _set_decrypt, notify=decryptChanged)

    def _get_filtered_content(self):
        return self._filtered_content

    filteredContent = QtCore.Property(str, _get_filtered_content, notify=ruleChanged)


def main():
    application = QtWidgets.QApplication(sys.argv)
    engine = QtQml.QQmlApplicationEngine()
    engine.addImportPath(":/resources/qml/")
    app = Application()
    engine.rootContext().setContextProperty("app", app)
    engine.load("qrc:/resources/qml/main.qml")
    application.exec_()
    sys.exit(0)


if __name__ == '__main__':
    main()
