CREATE OR REPLACE PROCEDURE SP_REMOVE_TABLE_CONSTRAINTS(V_TABLE_NAME IN VARCHAR2,
                                                        V_OWNER IN VARCHAR2)
AS
  CURSOR C1 IS
    SELECT AC.CONSTRAINT_NAME
    FROM ALL_CONSTRAINTS AC
    WHERE AC.TABLE_NAME = UPPER(V_TABLE_NAME)
      AND AC.OWNER = UPPER(V_OWNER);
BEGIN
  -- Remove constraints
  FOR REC IN C1 LOOP
    BEGIN
      EXECUTE IMMEDIATE 'ALTER TABLE ' || V_OWNER || '.' || V_TABLE_NAME || ' DROP CONSTRAINT ' || REC.CONSTRAINT_NAME;
    EXCEPTION
      WHEN OTHERS THEN
        -- Handle the exception
        DBMS_OUTPUT.PUT_LINE('Error dropping constraint: ' || SQLERRM);
    END;
  END LOOP;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error in SP_REMOVE_TABLE_CONSTRAINTS: ' || SQLERRM);
END SP_REMOVE_TABLE_CONSTRAINTS;
/
