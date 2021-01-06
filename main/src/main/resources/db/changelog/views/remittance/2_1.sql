create table RPRT_TB_FACT_LOGESTIC_TOZIN
(
  dat       varchar2(10),
  tozine_id varchar2(60) not null,
  sourceid  number,
  targetid  number,
  material  number not null,
  wazn      number,
  pkg       number,
  is_rail   number not null,
  key_1     varchar2(100),
  dat_ym    as (substr(dat,1,6)),
  dat_y     as (substr(dat,1,4)),  
  constraint pk_fact_logestic_tozin primary key (tozine_id)
);

create index idx_logstictozin_key1 on RPRT_TB_FACT_LOGESTIC_TOZIN (key_1);
create index idx_logstictozin_dat on RPRT_TB_FACT_LOGESTIC_TOZIN (DAT);
create index idx_FN_logstictozin_dat_date on RPRT_TB_FACT_LOGESTIC_TOZIN (to_date(dat, 'yyyymmdd', 'nls_calendar=persian'));
create index idx_logstictozin_srcid on RPRT_TB_FACT_LOGESTIC_TOZIN (SOURCEID);
create index idx_logstictozin_tgtid on RPRT_TB_FACT_LOGESTIC_TOZIN (TARGETID);
