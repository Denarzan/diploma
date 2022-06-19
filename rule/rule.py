from dataclasses import dataclass
from datetime import datetime
from typing import Optional


@dataclass
class Rule:
    after_datetime: Optional[datetime] = None
    before_datetime: Optional[datetime] = None
    host_name: Optional[str] = None
    IN: Optional[str] = None
    OUT: Optional[str] = None
    MAC: Optional[str] = None
    SRC: Optional[str] = None
    DST: Optional[str] = None
    min_len: Optional[int] = None
    max_len: Optional[int] = None
    TOS: Optional[str] = None
    PREC: Optional[str] = None
    TTL: Optional[int] = None
    id: Optional[int] = None
    CE: Optional[bool] = None
    DF: Optional[bool] = None
    MF: Optional[bool] = None
    PROTO: Optional[str] = None
    SPT: Optional[int] = None
    DPT: Optional[int] = None
    SEQ: Optional[int] = None
    ACK: Optional[bool] = None
    WINDOW: Optional[int] = None
    RES: Optional[str] = None
    packet_flags: Optional[bool] = None
    OPT: Optional[int] = None
