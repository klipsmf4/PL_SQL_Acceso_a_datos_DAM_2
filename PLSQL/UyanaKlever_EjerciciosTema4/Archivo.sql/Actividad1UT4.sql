
--------------Actividad_1------------------

CREATE OR REPLACE TYPE DIRECCION AS OBJECT (
CALLE VARCHAR2 (25),
CIUDAD VARCHAR2 (20),
CODIGO_POST NUMBER (5) );
--------------------------------------------
CREATE OR REPLACE TYPE PERSONA AS OBJECT (
CODIGO NUMBER, NOMBRE VARCHAR2 (35),
DIREC DIRECCION,
FECHA_NAC DATE );
--------------------------------------------
CREATE OR REPLACE TYPE T_ALUMNO AS OBJECT (
P1 PERSONA,
NOTA1 NUMBER(2),
NOTA2 NUMBER(2),
NOTA3 NUMBER(2) );
--------------------------------------------
--SET SERVEROUTPUT ON;
DECLARE
ALUMNO T_ALUMNO;
P PERSONA;
DIR DIRECCION;
BEGIN
P := NEW PERSONA(1,'KLEVER UYANA',DIR,'10/10/1994');
DIR := NEW DIRECCION('CABO DE GATA 3','MADRID','28290');
ALUMNO := NEW T_ALUMNO(P,8,7,9);
DBMS_OUTPUT.PUT_LINE('NOMBRE : ' || ALUMNO.P1.NOMBRE || '-NOTA 1�EVA : ' || ALUMNO.NOTA1 || '-NOTA 2�EVA : ' || ALUMNO.NOTA2 || '-NOTA 3�EVA : ' || ALUMNO.NOTA3 );
END;

--------------Actividad_2------------------

CREATE OR REPLACE TYPE T_ALUMNO AS OBJECT (
P1 PERSONA,
NOTA1 NUMBER(2),
NOTA2 NUMBER(2),
NOTA3 NUMBER(2),
MEMBER FUNCTION PROMEDIO
RETURN NUMBER
);
--------------------------------------------
CREATE OR REPLACE TYPE BODY T_ALUMNO AS
MEMBER FUNCTION PROMEDIO
RETURN NUMBER IS
BEGIN
RETURN (NOTA1+ NOTA2 + NOTA3)/3;
END;
END;
--------------------------------------------
DECLARE
ALUMNO T_ALUMNO;
P PERSONA;
DIR DIRECCION;
BEGIN
DIR := NEW DIRECCION('AVENIDA DE MARSIL 57','MADRID',28290);
P := NEW PERSONA(2,'CAMILA',DIR,'06/3/1997');
ALUMNO := NEW T_ALUMNO(P,8,7,9);
DBMS_OUTPUT.PUT_LINE('NOTA MEDIA: ' || ALUMNO.PROMEDIO);
END;

--------------Actividad_3------------------

CREATE OR REPLACE TYPE T_ALUMNO AS OBJECT (
ID_T_ALUMNO NUMBER,
P1 PERSONA,
NOTA1 NUMBER(2),
NOTA2 NUMBER(2),
NOTA3 NUMBER(2),
MEMBER FUNCTION PROMEDIO
RETURN NUMBER
);
-------------------------------------------
CREATE OR REPLACE TYPE BODY T_ALUMNO AS
MEMBER FUNCTION PROMEDIO
RETURN NUMBER IS
BEGIN
RETURN (NOTA1+ NOTA2 + NOTA3)/3;
END;
END;
-------------------------------------------
CREATE TABLE ALUMNO2 OF T_ALUMNO (
ID_T_ALUMNO PRIMARY KEY
);
-------------------------------------------
DECLARE
ALUMNO T_ALUMNO;
P PERSONA;
DIR DIRECCION;
BEGIN
DIR := NEW DIRECCION('AVENIDA DE MARSIL 57','MADRID',28290);
P := NEW PERSONA(1,'CAMILA',DIR,'06/3/1997');
ALUMNO := NEW T_ALUMNO(1,P,8,7,9);
INSERT INTO ALUMNO2 VALUES (ALUMNO);
COMMIT;
END;
--------------------------------------------
DECLARE
ALUMNO T_ALUMNO;
P PERSONA;
DIR DIRECCION;
BEGIN
DIR := NEW DIRECCION('CABO DE GATA 3','MADRID','28290');
P := NEW PERSONA(2,'KLEVER UYANA',DIR,'10/10/1994');
ALUMNO := NEW T_ALUMNO(2,P,8,7,9);
INSERT INTO ALUMNO2 VALUES (ALUMNO);
COMMIT;
END;
---------------------------------------------
DECLARE
ALUMNO T_ALUMNO;
P PERSONA;
DIR DIRECCION;
BEGIN
DIR := NEW DIRECCION('CABO DE GATA 3','MADRID','28290');
P := NEW PERSONA(3,'SANTIAGO UYANA',DIR,'10/10/1994');
ALUMNO := NEW T_ALUMNO(3,P,9,8,9);
INSERT INTO ALUMNO2 VALUES (ALUMNO);
COMMIT;
END;
-----------------------------------------------
SELECT * FROM ALUMNO2 ;
-----------------------------------------------
DECLARE
CURSOR C1 IS SELECT * FROM ALUMNO2;
BEGIN
DBMS_OUTPUT.PUT_LINE('NOMBRE DE ALUMNO Y SU NOTA MEDIA');
FOR I IN C1 LOOP
DBMS_OUTPUT.PUT_LINE('ID: '||I.ID_T_ALUMNO || ' NOMBRE: '||I.P1.NOMBRE ||'PROMEDIO: '||(I.NOTA1+I.NOTA2+I.NOTA3)/3);
END LOOP;
END;

------------------Actividad_4-------------------

CREATE TABLE AGENDA 
(
  ID NUMBER NOT NULL 
, NOMBRE VARCHAR2(50) 
, NUMERO NUMBER(11) 
, CONSTRAINT AGENDA_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);
-------------------------------------------------
CREATE OR REPLACE FUNCTION TELEFONO_NOM
(
NOMBRE2 IN VARCHAR2
)
RETURN NUMBER AS
TELEFONO_NOMBRE AGENDA.NUMERO%TYPE;
BEGIN
SELECT NUMERO INTO TELEFONO_NOMBRE FROM AGENDA WHERE NOMBRE=NOMBRE2;
RETURN TELEFONO_NOMBRE;
END TELEFONO_NOM;
--------------------------------------------------

DECLARE

BEGIN
DBMS_OUTPUT.PUT_LINE(TELEFONO_NOM('KLEVER'));
DBMS_OUTPUT.PUT_LINE(TELEFONO_NOM('CAMILA'));
END;
