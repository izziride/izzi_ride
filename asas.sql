CREATE OR REPLACE FUNCTION deactivate_fn()
RETURNS VOID AS $$
DECLARE
   map HSTORE;
BEGIN
  map := HSTORE(
    '<WORCSPACEID>', 'LIST<userId>',
    '<WORCSPACEID>', 'LIST<userId>',
    );
  FOR workspaceid IN SELECT (each(map)).key LOOP
    QUERY UPDATE project_access as pa 
    SET pa.deactivate = <BOOLEAN> 
    WHERE pa.project_id  IN 
    ( SELECT p.id 
       FROM projects as p
       WHERE p.workspace_id = workspaceid)
     AND pa.user_id IN map(workspaceid);
  END LOOP;
  RETURN value;
END;
$$ LANGUAGE plpgsql;
CALL deactivate_fn(); 
