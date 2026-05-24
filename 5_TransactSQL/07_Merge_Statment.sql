/* =========================================================
    MERGE Example 
   ========================================================= */

merge into lastt as T          -- Target table (main data)
using Dailyt as S              -- Source table (incoming updates)
on T.Lid = S.Dlid              -- Match rows using ID

when matched then
update
    set T.lvalue = T.lvalue + S.dvalue
                               --  update business value
                               -- Adds new value to existing value

when not matched then
insert values (S.dlid, S.dname, S.dvalue)
                               -- Insert new record if not found in target

output $action;                -- Shows INSERT or UPDATE action