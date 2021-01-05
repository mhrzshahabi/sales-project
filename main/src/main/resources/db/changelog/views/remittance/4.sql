create or replace procedure RPRT_PR_UPDATE_FACT_LOGESTICTOZIN as
  last_date_fa varchar2(100);
  run_hour number;
begin
  select to_number(to_char(systimestamp AT TIME ZONE 'Asia/Tehran', 'HH24')) into run_hour from dual;
  
  if run_hour <5  or run_hour>20 then
    execute immediate 'truncate table RPRT_TB_FACT_LOGESTIC_TOZIN';
  end if;
  
  select to_char(to_date(nvl(max(dat), '13900102'),'yyyymmdd', 'nls_calendar=persian')-1, 'yyyymmdd', 'nls_calendar=persian') 
         into last_date_fa
  from RPRT_TB_FACT_LOGESTIC_TOZIN;  
  
  merge into RPRT_TB_FACT_LOGESTIC_TOZIN d
  using (
          select distinct
             replace(sal_date2,'/','') dat,
             tozine_id, sourceid, targetid, 
             gdscode as material,
             wazn, 
             tedad as pkg,
             case when regexp_like(carno3, '[0-9]+') then 0 else 1 end as is_Rail,
             TO_CHAR(sourceid)||';'||TO_CHAR(gdscode) key_1              
          from v_tozine_content_m
          where sal_date2 is not null and tozine_id not like '3-%' and targetid in (2320, 2340, 2555) 
                and sal_date2 > last_date_fa) s
    on (d.tozine_id=s.tozine_id)
    when not matched then
      insert (d.dat, d.tozine_id, d.sourceid, d.targetid, d.material, d.wazn, d.pkg, d.is_rail)
      values (s.dat, s.tozine_id, s.sourceid, s.targetid, s.material, s.wazn, s.pkg, s.is_rail);

  commit;
end;
create or replace procedure RPRT_PR_UPDATE_REPORT as
begin
  RPRT_PR_UPDATE_FACT_LOGESTICTOZIN;
  dbms_mview.refresh('RPRT_MV_FACT_REMITTANCE');
  dbms_mview.refresh('RPRT_MV_MATERIAL_IO_SUMMARY');
  dbms_mview.refresh('RPRT_MV_MATERIAL_SHIPMENT_SUMMARY');
end;

