-- This SQL script creates a table with the hungarian cities and regions. It also adds the taxonomy identifiers from the appropriate taxonomy vocabularies.
SET NAMES 'utf8';

CREATE TABLE telepulesek(
  szotar integer(2),
  telepules_id integer(4),
  nev varchar(40),
  megye_id integer(4)
  );

CREATE TABLE megyek(
  szotar integer(2),
  telepules_id integer(4),
  nev varchar(40),
  megye_id integer(4)
  );

SOURCE create-table-telepulesek-data.sql

insert into megyek (select * from telepulesek where megye_id=0);

alter table telepulesek add column megye varchar(25);
update telepulesek t set megye=(select trim(replace(nev,'megye','')) from megyek m  where m.telepules_id=t.megye_id);
drop table megyek;

-- add tid to avoid joining on every select
alter table telepulesek add column tid integer(10);
update telepulesek set tid=(select tid from term_data where term_data.vid=14 and term_data.name collate utf8_hungarian_ci=telepulesek.nev collate utf8_hungarian_ci);

alter table telepulesek add column megye_tid integer(10);
update telepulesek set megye_tid=(select tid from term_data where term_data.vid=19 and term_data.name collate utf8_hungarian_ci=telepulesek.megye collate utf8_hungarian_ci);

-- Budapest
update telepulesek set megye_tid=(select tid from term_data where term_data.vid=19 and term_data.name collate utf8_hungarian_ci='Budapest' collate utf8_hungarian_ci) where nev='Budapest';

