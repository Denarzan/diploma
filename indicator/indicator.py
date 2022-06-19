from dataclasses import dataclass
from datetime import datetime


@dataclass
class Indicator:
    indicator_date: datetime
    host_name: str
    IN: str
    OUT: str
    MAC: str
    SRC: str
    DST: str
    LEN: int
    TOS: str
    PREC: str
    TTL: int
    id: int
    CE: bool
    DF: bool
    MF: bool
    PROTO: str
    SPT: int
    DPT: int
    SEQ: int
    ACK: bool
    WINDOW: int
    RES: str
    packet_flags: bool
    OPT: int
    string_data: str  # string from what we take data
