CRUD :
Create
insert into namatabel values
('isidata', 'data'),
('datarowkedua', 'data');

Read
select * from namatabel; (all semua)
select namakolom from namatabel where namakolom = 'value'; 
select namakolom, namakolom from namatabel where namakolom='value'; (lebih spesifik)

Update
update namatabel
set namakolom = 'value'
where namakolom = 'value'; (mengubah data value)
alter table namatabel change namakolom namakolombaru jenisdata(value); (mengubah nama kolom)

Delete
delete from namatabel
where namakolom = 'value';
