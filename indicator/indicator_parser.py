from abc import ABC
import re
from datetime import datetime

from indicator.indicator import Indicator


class IndicatorParser(ABC):
    def parse(self, indicator_data: str):
        raise NotImplementedError()


class ZeekIndicatorParser(IndicatorParser):
    def parse(self, indicator_data: str):
        pattern = re.compile(
            r"(?P<string_data>(?P<month>[A-Z][a-z]*)"
            r" (?P<day>\d*)"
            r" (?P<hours>\d*):(?P<minutes>\d*):(?P<seconds>\d*)"
            r" (?P<host_name>\S*)"
            r" kernel: \[(?P<num1>\d*)\.(?P<num2>\d*)\]"
            r"(?: Iptables:)?"
            r"(?: IN=(?P<IN>\S*))?"
            r"(?: OUT=(?P<OUT>\S*))?"
            r"(?: MAC=(?P<MAC>\S*))?"
            r"(?: SRC=(?P<SRC>\S*))?"
            r"(?: DST=(?P<DST>\S*))?"
            r"(?: LEN=(?P<LEN>\S*))?"
            r"(?: TOS=(?P<TOS>\S*))?"
            r"(?: PREC=(?P<PREC>\S*))?"
            r"(?: TTL=(?P<TTL>\S*))?"
            r"(?: ID=(?P<id>\S*))?"
            r"(?: (?P<CE>CE))?"
            r"(?: (?P<DF>DF))?"
            r"(?: (?P<MF>MF))?"
            r"(?: PROTO=(?P<PROTO>\S*))?"
            r"(?: SPT=(?P<SPT>\S*))?"
            r"(?: DPT=(?P<DPT>\S*))?"
            r"(?: SEQ=(?P<SEQ>\S*))?"
            r"(?: ACK=(?P<ACK>\S*))?"
            r"(?: WINDOW=(?P<WINDOW>\S*))?"
            r"(?: RES=(?P<RES>\S*))?"
            r"(?: SYN URGP=(?P<packet_flags>\S*))?"
            r"(?: OPT \((?P<OPT>\S*)\))?)"
        )
        indicators = []
        for row in re.finditer(pattern, indicator_data):
            row_data = row.groupdict()
            indicators.append(Indicator(
                indicator_date=datetime(
                    datetime.now().year,
                    datetime.strptime(row_data["month"], "%B").month,
                    int(row_data["day"]),
                    int(row_data["hours"]),
                    int(row_data["minutes"]),
                    int(row_data["seconds"])
                ),
                host_name=row_data["host_name"],
                IN=row_data["IN"],
                OUT=row_data["OUT"],
                MAC=row_data["MAC"],
                SRC=row_data["SRC"],
                DST=row_data["DST"],
                LEN=int(row_data.get("LEN", -1) or -1),
                TOS=row_data["TOS"],
                PREC=row_data["PREC"],
                TTL=int(row_data.get("TTL", -1) or -1),
                id=int(row_data.get("id", -1) or -1),
                CE=bool(row_data["CE"]),
                DF=bool(row_data["DF"]),
                MF=bool(row_data["MF"]),
                PROTO=row_data["PROTO"],
                SPT=int(row_data.get("SPT", -1) or -1),
                DPT=int(row_data.get("DPT", -1) or -1),
                SEQ=int(row_data.get("SEQ", -1) or -1),
                ACK=bool(row_data["ACK"]),
                WINDOW=int(row_data.get("WINDOW", -1) or -1),
                RES=row_data["RES"],
                packet_flags=bool(row_data["packet_flags"]),
                OPT=int(row_data.get("OPT", -1) or -1),
                string_data=row_data["string_data"],
            ))
        return indicators
