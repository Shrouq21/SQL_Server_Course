
merge into lastt as T          -- Target table (main data)
using Dailyt as S             
on T.Lid = S.Dlid              -- Match rows using ID

-- MERGE compares a source table with a target table
-- and can INSERT, UPDATE, or DELETE depending on the conditions.

when matched then
update
    set T.lvalue = T.lvalue + S.dvalue
                               --  update business value
                               -- Adds new value to existing value

when not matched then
insert values (S.dlid, S.dname, S.dvalue)
                               -- Insert new record if not found in target

output $action;                -- Shows INSERT or UPDATE action