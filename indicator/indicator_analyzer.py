from typing import Set

from indicator.indicator import Indicator
from rule.rule import Rule


class IndicatorAnalyzer:
    @staticmethod
    def not_exist_or_equal(first, second):
        return not first or not second or first == second

    @staticmethod
    def indicator_fits_rule(rule: Rule, indicator: Indicator):
        return all([
            not rule.after_datetime or not indicator.indicator_date or rule.after_datetime < indicator.indicator_date,
            not rule.before_datetime or not indicator.indicator_date or rule.before_datetime > indicator.indicator_date,
            IndicatorAnalyzer.not_exist_or_equal(rule.host_name, indicator.host_name),
            IndicatorAnalyzer.not_exist_or_equal(rule.IN, indicator.IN),
            IndicatorAnalyzer.not_exist_or_equal(rule.OUT, indicator.OUT),
            IndicatorAnalyzer.not_exist_or_equal(rule.MAC, indicator.MAC),
            IndicatorAnalyzer.not_exist_or_equal(rule.SRC, indicator.SRC),
            IndicatorAnalyzer.not_exist_or_equal(rule.DST, indicator.DST),
            not rule.min_len or not indicator.LEN or rule.min_len < indicator.LEN,
            not rule.max_len or not indicator.LEN or rule.max_len > indicator.LEN,
            IndicatorAnalyzer.not_exist_or_equal(rule.TOS, indicator.TOS),
            IndicatorAnalyzer.not_exist_or_equal(rule.PREC, indicator.PREC),
            IndicatorAnalyzer.not_exist_or_equal(rule.TTL, indicator.TTL),
            IndicatorAnalyzer.not_exist_or_equal(rule.id, indicator.id),
            IndicatorAnalyzer.not_exist_or_equal(rule.CE, indicator.CE),
            IndicatorAnalyzer.not_exist_or_equal(rule.DF, indicator.DF),
            IndicatorAnalyzer.not_exist_or_equal(rule.MF, indicator.MF),
            IndicatorAnalyzer.not_exist_or_equal(rule.PROTO, indicator.PROTO),
            IndicatorAnalyzer.not_exist_or_equal(rule.SPT, indicator.SPT),
            IndicatorAnalyzer.not_exist_or_equal(rule.DPT, indicator.DPT),
            IndicatorAnalyzer.not_exist_or_equal(rule.SEQ, indicator.SEQ),
            IndicatorAnalyzer.not_exist_or_equal(rule.ACK, indicator.ACK),
            IndicatorAnalyzer.not_exist_or_equal(rule.WINDOW, indicator.WINDOW),
            IndicatorAnalyzer.not_exist_or_equal(rule.RES, indicator.RES),
            IndicatorAnalyzer.not_exist_or_equal(rule.packet_flags, indicator.packet_flags),
            IndicatorAnalyzer.not_exist_or_equal(rule.OPT, indicator.OPT),
        ])

    @staticmethod
    def analyze_indicators(indicators: Set[Indicator], rules: Set[Rule]) -> Set[Indicator]:
        indicator_set = set()
        for rule in rules:
            indicator_set.update(
                set(filter(
                    lambda indicator: IndicatorAnalyzer.indicator_fits_rule(rule, indicator),
                    indicators
                ))
            )
        return indicator_set
