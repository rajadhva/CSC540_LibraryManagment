set SERVEROUTPUT ON

Create or Replace procedure journals_fine     --duedate IN TIMESTAMP
IS
cursor j_fine is select resource_id,fine,returndate from journals_checkout
where duedate< localtimestamp+2; 
presource_id VARCHAR2(20);
pfine Number;
preturndate timestamp;
Begin
            Open j_fine;
            LOOP
            fetch j_fine into presource_id,pfine,preturndate;
            exit when j_fine%notfound;
            --pfine:=v_fine.fine;
            --preturndate:=v_fine.returndate;
            --DBMS_OUTPUT.PUT_LINE(REC.FINE || 'hI' || REC.RETURNDATE);
            if(preturndate is null) then
            DBMS_OUTPUT.PUT_LINE('here2');
               --if(pfine=0) then
               --DBMS_OUTPUT.PUT_LINE('here3');
                 update journals_checkout set fine=(select fine from journals_checkout where resource_id=presource_id)+2 where resource_id=presource_id;
                 --else
                 --DBMS_OUTPUT.PUT_LINE('here4');
                 --update journals_checkout set fine= pfine+ 2;
                 --end if;
            end if;     
            EXIT WHEN J_FINE%ROWCOUNT=0;
            END LOOP;
            commit;
END;           

Begin            
DBMS_SCHEDULER.CREATE_JOB(job_name=>'finecalculation',
                          job_type=>'Stored_Procedure',
                          JOB_ACTION=>'SYS.JOURNALS_FINE',
                          start_date=>'31-OCT-2015 12:05:00 AM',
                          repeat_interval=>'freq=Daily',
                          end_date=>NULL,
                          enabled=>TRUE,
                          comments=>'Calls fine procedure oto calculate fines in all tables');
End;
/

begin
dbms_scheduler.set_attribute (
name               =>  'FINECALCULATION',
attribute          =>  'job_name',
value              =>  'journalsfinecalculation');
end;

begin
dbms_scheduler.set_attribute (
name               =>  'finecalculation',
attribute          =>  'start_date',
value              =>  '01-NOV-2015 12:05:00 AM');
end;


exec journals_fine

select * from journals_checkout;


--job log related stuff
select * from ALL_SCHEDULER_JOB_LOG;
 
SELECT * FROM USER_SCHEDULER_JOB_LOG; 

SELECT * from USER_SCHEDULER_JOBS where job_name='finecalculation';
Select * from all_scheduler_job_log where job_name='finecalculation';
Select * from USER_SCHEDULER_JOB_RUN_DETAILS where job_name='FINECALCULATION';

select sys_context( 'userenv', 'current_schema' ) from dual;
update journals_checkout
set fine=0
where resource_id='J1' or resource_id='J2';

