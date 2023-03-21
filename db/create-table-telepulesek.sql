-- This SQL script creates a table with the hungarian cities and regions. It also adds the taxonomy identifiers from the appropriate taxonomy vocabularies.
SET NAMES 'utf8';

CREATE TABLE telepulesek(
  szotar integer(2),
  telepules_id integer(4),
  nev varchar(40),
  varmegye_id integer(4)
  );

CREATE TABLE varmegyek(
  szotar integer(2),
  telepules_id integer(4),
  nev varchar(40),
  varmegye_id integer(4)
  );

SOURCE create-table-telepulesek-data.sql

insert into varmegyek (select * from telepulesek where varmegye_id=0);

alter table telepulesek add column varmegye varchar(25);
update telepulesek t set varmegye=(select trim(replace(nev,'vármegye','')) from varmegyek m  where m.telepules_id=t.varmegye_id);
drop table varmegyek;

-- add tid to avoid joining on every select
alter table telepulesek add column tid integer(10);
update telepulesek set tid=(select tid from term_data where term_data.vid=14 and term_data.name collate utf8_hungarian_ci=telepulesek.nev collate utf8_hungarian_ci);

alter table telepulesek add column varmegye_tid integer(10);
update telepulesek set varmegye_tid=(select tid from term_data where term_data.vid=19 and term_data.name collate utf8_hungarian_ci=telepulesek.varmegye collate utf8_hungarian_ci);

-- Budapest
update telepulesek set varmegye_tid=(select tid from term_data where term_data.vid=19 and term_data.name collate utf8_hungarian_ci='Budapest' collate utf8_hungarian_ci) where nev='Budapest';

