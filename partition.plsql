create table ekle(
  ekle_id number,
  ekle_date date
)
partition by range (ekle_date) (
  partition p_01042023 values less than (to_date('01-04-2023','dd-mm-yyyy'))
);

drop table ekle


DECLARE
   baslangic_date DATE := TO_DATE('01-07-2023', 'DD-MM-YYYY');
   bitis_date DATE := TO_DATE('01-08-2023', 'DD-MM-YYYY');
   partition_count NUMBER := 0;
   ekle_id_counter NUMBER := 1;
BEGIN
   WHILE baslangic_date < bitis_date LOOP
      
         SELECT COUNT(*)
         INTO partition_count
         FROM user_tab_partitions
         WHERE table_name = 'EKLE' AND partition_name = 'P_' || TO_CHAR(baslangic_date, 'DDMMYYYY');
         
               IF partition_count = 0 THEN
                  EXECUTE IMMEDIATE 'ALTER TABLE ekle ADD PARTITION p_' || TO_CHAR(baslangic_date, 'DDMMYYYY') ||
                              ' VALUES LESS THAN (TO_DATE(''' || TO_CHAR(baslangic_date, 'DD-MM-YYYY') || ''', ''DD-MM-YYYY''))';
           else 
             DBMS_OUTPUT.PUT_LINE(baslangic_date);
              END IF;
         
         COMMIT;
         
         
         ekle_id_counter := ekle_id_counter + 1;
      baslangic_date := baslangic_date + 1;
   END LOOP;
   
   END;
