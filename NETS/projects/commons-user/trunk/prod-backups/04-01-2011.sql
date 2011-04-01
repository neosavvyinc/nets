--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'SQL_ASCII';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- Name: commonsuser; Type: SCHEMA; Schema: -; Owner: commonsuser
--

CREATE SCHEMA commonsuser;


ALTER SCHEMA commonsuser OWNER TO commonsuser;

SET search_path = commonsuser, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: acl_class; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE acl_class (
    id bigint NOT NULL,
    class character varying(255) NOT NULL
);


ALTER TABLE commonsuser.acl_class OWNER TO commonsuser;

--
-- Name: acl_class_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE acl_class_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.acl_class_id_seq OWNER TO commonsuser;

--
-- Name: acl_class_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE acl_class_id_seq OWNED BY acl_class.id;


--
-- Name: acl_class_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('acl_class_id_seq', 9, true);


--
-- Name: acl_entry; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE acl_entry (
    id bigint NOT NULL,
    granting boolean NOT NULL,
    ace_order integer,
    audit_success boolean NOT NULL,
    mask integer NOT NULL,
    audit_failure boolean NOT NULL,
    acl_object_identity bigint NOT NULL,
    sid bigint NOT NULL
);


ALTER TABLE commonsuser.acl_entry OWNER TO commonsuser;

--
-- Name: acl_entry_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE acl_entry_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.acl_entry_id_seq OWNER TO commonsuser;

--
-- Name: acl_entry_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE acl_entry_id_seq OWNED BY acl_entry.id;


--
-- Name: acl_entry_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('acl_entry_id_seq', 99, true);


--
-- Name: acl_object_identity; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE acl_object_identity (
    id bigint NOT NULL,
    object_id_identity bigint NOT NULL,
    entries_inheriting boolean NOT NULL,
    parent_object bigint,
    object_id_class bigint NOT NULL,
    owner_sid bigint NOT NULL
);


ALTER TABLE commonsuser.acl_object_identity OWNER TO commonsuser;

--
-- Name: acl_object_identity_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE acl_object_identity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.acl_object_identity_id_seq OWNER TO commonsuser;

--
-- Name: acl_object_identity_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE acl_object_identity_id_seq OWNED BY acl_object_identity.id;


--
-- Name: acl_object_identity_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('acl_object_identity_id_seq', 157, true);


--
-- Name: acl_sid; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE acl_sid (
    id bigint NOT NULL,
    sid character varying(100) NOT NULL,
    principal boolean NOT NULL
);


ALTER TABLE commonsuser.acl_sid OWNER TO commonsuser;

--
-- Name: acl_sid_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE acl_sid_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.acl_sid_id_seq OWNER TO commonsuser;

--
-- Name: acl_sid_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE acl_sid_id_seq OWNED BY acl_sid.id;


--
-- Name: acl_sid_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('acl_sid_id_seq', 4, true);


--
-- Name: attribute_descriptor; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE attribute_descriptor (
    id bigint NOT NULL,
    type character varying(50),
    "precision" integer DEFAULT 2,
    description character varying(255),
    sort_order integer,
    name character varying(255),
    valuetype character varying(255)
);


ALTER TABLE commonsuser.attribute_descriptor OWNER TO commonsuser;

--
-- Name: attribute_descriptor_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE attribute_descriptor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.attribute_descriptor_id_seq OWNER TO commonsuser;

--
-- Name: attribute_descriptor_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE attribute_descriptor_id_seq OWNED BY attribute_descriptor.id;


--
-- Name: attribute_descriptor_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('attribute_descriptor_id_seq', 1, false);


--
-- Name: attribute_enum_value; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE attribute_enum_value (
    id bigint NOT NULL,
    sort_order integer,
    value character varying(255),
    descriptor_id bigint
);


ALTER TABLE commonsuser.attribute_enum_value OWNER TO commonsuser;

--
-- Name: attribute_enum_value_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE attribute_enum_value_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.attribute_enum_value_id_seq OWNER TO commonsuser;

--
-- Name: attribute_enum_value_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE attribute_enum_value_id_seq OWNED BY attribute_enum_value.id;


--
-- Name: attribute_enum_value_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('attribute_enum_value_id_seq', 1, false);


--
-- Name: client_company; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE client_company (
    id bigint NOT NULL,
    address_two character varying(255),
    postal_code character varying(255),
    address_one character varying(255),
    state character varying(255),
    company_name character varying(255),
    city character varying(255),
    country character varying(255),
    client_user_contact_fk bigint NOT NULL,
    parent_company_fk bigint NOT NULL
);


ALTER TABLE commonsuser.client_company OWNER TO commonsuser;

--
-- Name: client_company_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE client_company_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.client_company_id_seq OWNER TO commonsuser;

--
-- Name: client_company_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE client_company_id_seq OWNED BY client_company.id;


--
-- Name: client_company_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('client_company_id_seq', 2, true);


--
-- Name: client_user_contact; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE client_user_contact (
    id bigint NOT NULL,
    middle_name character varying(255),
    last_name character varying(255),
    email_address character varying(255),
    contact_phone_number character varying(255),
    first_name character varying(255)
);


ALTER TABLE commonsuser.client_user_contact OWNER TO commonsuser;

--
-- Name: client_user_contact_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE client_user_contact_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.client_user_contact_id_seq OWNER TO commonsuser;

--
-- Name: client_user_contact_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE client_user_contact_id_seq OWNED BY client_user_contact.id;


--
-- Name: client_user_contact_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('client_user_contact_id_seq', 2, true);


--
-- Name: company; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE company (
    id bigint NOT NULL,
    address_one character varying(255),
    address_two character varying(255),
    postal_code character varying(255),
    state character varying(255),
    company_name character varying(255),
    city character varying(255),
    country character varying(255)
);


ALTER TABLE commonsuser.company OWNER TO commonsuser;

--
-- Name: company_expense_item_type; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE company_expense_item_type (
    id bigint NOT NULL,
    company_fk bigint NOT NULL
);


ALTER TABLE commonsuser.company_expense_item_type OWNER TO commonsuser;

--
-- Name: company_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE company_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.company_id_seq OWNER TO commonsuser;

--
-- Name: company_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE company_id_seq OWNED BY company.id;


--
-- Name: company_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('company_id_seq', 2, true);


--
-- Name: company_payment_method; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE company_payment_method (
    id bigint NOT NULL,
    company_fk bigint NOT NULL
);


ALTER TABLE commonsuser.company_payment_method OWNER TO commonsuser;

--
-- Name: databasechangelog; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE databasechangelog (
    id character varying(63) NOT NULL,
    author character varying(63) NOT NULL,
    filename character varying(200) NOT NULL,
    dateexecuted timestamp with time zone NOT NULL,
    md5sum character varying(32),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(10)
);


ALTER TABLE commonsuser.databasechangelog OWNER TO commonsuser;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp with time zone,
    lockedby character varying(255)
);


ALTER TABLE commonsuser.databasechangeloglock OWNER TO commonsuser;

--
-- Name: expense_item_descriptor; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE expense_item_descriptor (
    id bigint NOT NULL,
    expense_item_type_fk bigint NOT NULL
);


ALTER TABLE commonsuser.expense_item_descriptor OWNER TO commonsuser;

--
-- Name: expense_item_type; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE expense_item_type (
    id bigint NOT NULL,
    type character varying(50),
    name character varying(255),
    description character varying(255),
    sort_order integer
);


ALTER TABLE commonsuser.expense_item_type OWNER TO commonsuser;

--
-- Name: expense_item_type_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE expense_item_type_id_seq
    START WITH 1
    INCREMENT BY 50
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.expense_item_type_id_seq OWNER TO commonsuser;

--
-- Name: expense_item_type_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE expense_item_type_id_seq OWNED BY expense_item_type.id;


--
-- Name: expense_item_type_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('expense_item_type_id_seq', 1, false);


--
-- Name: expense_item_value; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE expense_item_value (
    id bigint NOT NULL,
    string_value character varying(255),
    partition_date date NOT NULL,
    enumerated_value_id bigint,
    expense_item_fk bigint NOT NULL,
    descriptor_id bigint NOT NULL
);


ALTER TABLE commonsuser.expense_item_value OWNER TO commonsuser;

--
-- Name: expense_item_value_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE expense_item_value_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.expense_item_value_id_seq OWNER TO commonsuser;

--
-- Name: expense_item_value_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE expense_item_value_id_seq OWNED BY expense_item_value.id;


--
-- Name: expense_item_value_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('expense_item_value_id_seq', 1, false);


--
-- Name: expense_item_value_yy10mm01; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE expense_item_value_yy10mm01 (CONSTRAINT expense_item_value_yy10mm01_partition_date_check CHECK (((partition_date >= '2010-01-01'::date) AND (partition_date < '2010-06-01'::date)))
)
INHERITS (expense_item_value);


ALTER TABLE commonsuser.expense_item_value_yy10mm01 OWNER TO commonsuser;

--
-- Name: expense_item_value_yy10mm06; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE expense_item_value_yy10mm06 (CONSTRAINT expense_item_value_yy10mm06_partition_date_check CHECK (((partition_date >= '2010-06-01'::date) AND (partition_date < '2011-01-01'::date)))
)
INHERITS (expense_item_value);


ALTER TABLE commonsuser.expense_item_value_yy10mm06 OWNER TO commonsuser;

--
-- Name: expense_item_value_yy11mm01; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE expense_item_value_yy11mm01 (CONSTRAINT expense_item_value_yy11mm01_partition_date_check CHECK (((partition_date >= '2011-01-01'::date) AND (partition_date < '2011-06-01'::date)))
)
INHERITS (expense_item_value);


ALTER TABLE commonsuser.expense_item_value_yy11mm01 OWNER TO commonsuser;

--
-- Name: expense_item_value_yy11mm06; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE expense_item_value_yy11mm06 (CONSTRAINT expense_item_value_yy11mm06_partition_date_check CHECK (((partition_date >= '2011-06-01'::date) AND (partition_date < '2012-01-01'::date)))
)
INHERITS (expense_item_value);


ALTER TABLE commonsuser.expense_item_value_yy11mm06 OWNER TO commonsuser;

--
-- Name: expense_report; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE expense_report (
    id bigint NOT NULL,
    state_date date,
    location character varying(255),
    end_date date,
    purpose character varying(255),
    owner_fk bigint NOT NULL,
    project_fk bigint,
    status character varying(20) DEFAULT 'OPEN'::character varying NOT NULL
);


ALTER TABLE commonsuser.expense_report OWNER TO commonsuser;

--
-- Name: expense_report_audit_history; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE expense_report_audit_history (
    id bigint NOT NULL,
    comment character varying(4098) NOT NULL,
    activity_date date NOT NULL,
    user_fk bigint NOT NULL,
    owner_fk bigint NOT NULL,
    expense_report_fk bigint NOT NULL
);


ALTER TABLE commonsuser.expense_report_audit_history OWNER TO commonsuser;

--
-- Name: expense_report_audit_history_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE expense_report_audit_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.expense_report_audit_history_id_seq OWNER TO commonsuser;

--
-- Name: expense_report_audit_history_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE expense_report_audit_history_id_seq OWNED BY expense_report_audit_history.id;


--
-- Name: expense_report_audit_history_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('expense_report_audit_history_id_seq', 1, false);


--
-- Name: expense_report_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE expense_report_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.expense_report_id_seq OWNER TO commonsuser;

--
-- Name: expense_report_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE expense_report_id_seq OWNED BY expense_report.id;


--
-- Name: expense_report_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('expense_report_id_seq', 3, true);


--
-- Name: expense_report_item; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE expense_report_item (
    id bigint NOT NULL,
    amount numeric(38,2),
    expense_date date,
    comment character varying(255),
    expense_report_fk bigint NOT NULL,
    expense_item_type_fk bigint,
    payment_method_fk bigint,
    project_type_fk bigint,
    receipt_file_ref_fk bigint
);


ALTER TABLE commonsuser.expense_report_item OWNER TO commonsuser;

--
-- Name: expense_report_item_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE expense_report_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.expense_report_item_id_seq OWNER TO commonsuser;

--
-- Name: expense_report_item_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE expense_report_item_id_seq OWNED BY expense_report_item.id;


--
-- Name: expense_report_item_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('expense_report_item_id_seq', 134, true);


--
-- Name: file_refs; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE file_refs (
    id bigint NOT NULL,
    type character varying(50) NOT NULL,
    file_size character varying(4098) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    last_modified_at timestamp with time zone NOT NULL,
    record_status character varying(1) NOT NULL
);


ALTER TABLE commonsuser.file_refs OWNER TO commonsuser;

--
-- Name: file_refs_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE file_refs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.file_refs_id_seq OWNER TO commonsuser;

--
-- Name: file_refs_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE file_refs_id_seq OWNED BY file_refs.id;


--
-- Name: file_refs_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('file_refs_id_seq', 7, true);


--
-- Name: payment_method; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE payment_method (
    id bigint NOT NULL,
    type character varying(31),
    description character varying(255),
    name character varying(255)
);


ALTER TABLE commonsuser.payment_method OWNER TO commonsuser;

--
-- Name: payment_method_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE payment_method_id_seq
    START WITH 1
    INCREMENT BY 3
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.payment_method_id_seq OWNER TO commonsuser;

--
-- Name: payment_method_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE payment_method_id_seq OWNED BY payment_method.id;


--
-- Name: payment_method_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('payment_method_id_seq', 1, false);


--
-- Name: project; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE project (
    id bigint NOT NULL,
    start_date date,
    project_name character varying(255),
    end_date date,
    code character varying(255),
    parent_company_fk bigint NOT NULL,
    client_company_fk bigint NOT NULL
);


ALTER TABLE commonsuser.project OWNER TO commonsuser;

--
-- Name: project_approvers; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE project_approvers (
    user_id bigint NOT NULL,
    project_id bigint NOT NULL
);


ALTER TABLE commonsuser.project_approvers OWNER TO commonsuser;

--
-- Name: project_approvers_user_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE project_approvers_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.project_approvers_user_id_seq OWNER TO commonsuser;

--
-- Name: project_approvers_user_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE project_approvers_user_id_seq OWNED BY project_approvers.user_id;


--
-- Name: project_approvers_user_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('project_approvers_user_id_seq', 1, false);


--
-- Name: project_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE project_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.project_id_seq OWNER TO commonsuser;

--
-- Name: project_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE project_id_seq OWNED BY project.id;


--
-- Name: project_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('project_id_seq', 2, true);


--
-- Name: project_participants; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE project_participants (
    user_id bigint NOT NULL,
    project_id bigint NOT NULL
);


ALTER TABLE commonsuser.project_participants OWNER TO commonsuser;

--
-- Name: project_participants_user_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE project_participants_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.project_participants_user_id_seq OWNER TO commonsuser;

--
-- Name: project_participants_user_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE project_participants_user_id_seq OWNED BY project_participants.user_id;


--
-- Name: project_participants_user_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('project_participants_user_id_seq', 1, false);


--
-- Name: project_payment_method; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE project_payment_method (
    id bigint NOT NULL,
    project_fk bigint NOT NULL
);


ALTER TABLE commonsuser.project_payment_method OWNER TO commonsuser;

--
-- Name: project_type; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE project_type (
    id bigint NOT NULL,
    type character varying(255)
);


ALTER TABLE commonsuser.project_type OWNER TO commonsuser;

--
-- Name: project_type_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE project_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.project_type_id_seq OWNER TO commonsuser;

--
-- Name: project_type_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE project_type_id_seq OWNED BY project_type.id;


--
-- Name: project_type_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('project_type_id_seq', 3, true);


--
-- Name: role; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE role (
    id bigint NOT NULL,
    long_name character varying(255),
    short_name character varying(255)
);


ALTER TABLE commonsuser.role OWNER TO commonsuser;

--
-- Name: role_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.role_id_seq OWNER TO commonsuser;

--
-- Name: role_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE role_id_seq OWNED BY role.id;


--
-- Name: role_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('role_id_seq', 2, true);


--
-- Name: standard_expense_item_type; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE standard_expense_item_type (
    id bigint NOT NULL
);


ALTER TABLE commonsuser.standard_expense_item_type OWNER TO commonsuser;

--
-- Name: standard_payment_method; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE standard_payment_method (
    id bigint NOT NULL
);


ALTER TABLE commonsuser.standard_payment_method OWNER TO commonsuser;

--
-- Name: storage_service_file_refs; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE storage_service_file_refs (
    id bigint NOT NULL,
    bucket character varying(50) NOT NULL,
    file_key character varying(100) NOT NULL,
    file_name character varying(256),
    location character varying(20),
    content_type character varying(50),
    owner character varying(256)
);


ALTER TABLE commonsuser.storage_service_file_refs OWNER TO commonsuser;

--
-- Name: user_company_role; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE user_company_role (
    id bigint NOT NULL,
    role_fk bigint NOT NULL,
    company_fk bigint NOT NULL,
    user_fk bigint NOT NULL
);


ALTER TABLE commonsuser.user_company_role OWNER TO commonsuser;

--
-- Name: user_company_role_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE user_company_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.user_company_role_id_seq OWNER TO commonsuser;

--
-- Name: user_company_role_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE user_company_role_id_seq OWNED BY user_company_role.id;


--
-- Name: user_company_role_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('user_company_role_id_seq', 3, true);


--
-- Name: user_invite; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE user_invite (
    id bigint NOT NULL,
    middle_name character varying(255),
    last_name character varying(255),
    email_address character varying(255),
    contact_phone_number character varying(255),
    first_name character varying(255),
    registration_token character varying(255),
    company_fk bigint NOT NULL
);


ALTER TABLE commonsuser.user_invite OWNER TO commonsuser;

--
-- Name: user_invite_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE user_invite_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.user_invite_id_seq OWNER TO commonsuser;

--
-- Name: user_invite_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE user_invite_id_seq OWNED BY user_invite.id;


--
-- Name: user_invite_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('user_invite_id_seq', 2, true);


--
-- Name: user_receipts; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE user_receipts (
    user_fk bigint NOT NULL,
    receipt_fk bigint NOT NULL
);


ALTER TABLE commonsuser.user_receipts OWNER TO commonsuser;

--
-- Name: user_sessions; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE user_sessions (
    id character varying(100) NOT NULL,
    username character varying(256) NOT NULL,
    creation_date timestamp with time zone NOT NULL
);


ALTER TABLE commonsuser.user_sessions OWNER TO commonsuser;

--
-- Name: users; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE users (
    id bigint NOT NULL,
    middle_name character varying(255),
    last_name character varying(255),
    email_address character varying(255),
    contact_phone_number character varying(255),
    password character varying(255),
    username character varying(255),
    active boolean,
    first_name character varying(255),
    confirmed_registration boolean,
    reg_token character varying(255),
    password_reset boolean DEFAULT false NOT NULL
);


ALTER TABLE commonsuser.users OWNER TO commonsuser;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.users_id_seq OWNER TO commonsuser;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('users_id_seq', 3, true);


--
-- Name: id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE acl_class ALTER COLUMN id SET DEFAULT nextval('acl_class_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE acl_entry ALTER COLUMN id SET DEFAULT nextval('acl_entry_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE acl_object_identity ALTER COLUMN id SET DEFAULT nextval('acl_object_identity_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE acl_sid ALTER COLUMN id SET DEFAULT nextval('acl_sid_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE attribute_descriptor ALTER COLUMN id SET DEFAULT nextval('attribute_descriptor_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE attribute_enum_value ALTER COLUMN id SET DEFAULT nextval('attribute_enum_value_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE client_company ALTER COLUMN id SET DEFAULT nextval('client_company_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE client_user_contact ALTER COLUMN id SET DEFAULT nextval('client_user_contact_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE company ALTER COLUMN id SET DEFAULT nextval('company_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE expense_item_type ALTER COLUMN id SET DEFAULT nextval('expense_item_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE expense_item_value ALTER COLUMN id SET DEFAULT nextval('expense_item_value_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE expense_report ALTER COLUMN id SET DEFAULT nextval('expense_report_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE expense_report_audit_history ALTER COLUMN id SET DEFAULT nextval('expense_report_audit_history_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE expense_report_item ALTER COLUMN id SET DEFAULT nextval('expense_report_item_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE file_refs ALTER COLUMN id SET DEFAULT nextval('file_refs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE payment_method ALTER COLUMN id SET DEFAULT nextval('payment_method_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE project ALTER COLUMN id SET DEFAULT nextval('project_id_seq'::regclass);


--
-- Name: user_id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE project_approvers ALTER COLUMN user_id SET DEFAULT nextval('project_approvers_user_id_seq'::regclass);


--
-- Name: user_id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE project_participants ALTER COLUMN user_id SET DEFAULT nextval('project_participants_user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE project_type ALTER COLUMN id SET DEFAULT nextval('project_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE role ALTER COLUMN id SET DEFAULT nextval('role_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE user_company_role ALTER COLUMN id SET DEFAULT nextval('user_company_role_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE user_invite ALTER COLUMN id SET DEFAULT nextval('user_invite_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: acl_class; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY acl_class (id, class) FROM stdin;
1	com.neosavvy.user.dto.companyManagement.UserDTO
2	com.neosavvy.user.dto.companyManagement.CompanyDTO
3	com.neosavvy.user.dto.companyManagement.UserInviteDTO
4	com.neosavvy.user.dto.project.ClientUserContact
5	com.neosavvy.user.dto.project.ClientCompany
6	com.neosavvy.user.dto.project.Project
7	com.neosavvy.user.dto.project.ExpenseReport
8	com.neosavvy.user.dto.project.ExpenseItem
9	fineline.focal.common.types.v1.StorageServiceFileRef
\.


--
-- Data for Name: acl_entry; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY acl_entry (id, granting, ace_order, audit_success, mask, audit_failure, acl_object_identity, sid) FROM stdin;
4	t	0	f	1	f	1	2
5	t	1	f	2	f	1	2
6	t	2	f	8	f	1	2
10	t	0	f	1	f	2	2
11	t	1	f	2	f	2	2
12	t	2	f	8	f	2	2
19	t	0	f	1	f	4	3
20	t	1	f	2	f	4	3
21	t	2	f	8	f	4	3
23	t	0	f	1	f	9	3
24	t	1	f	1	f	9	2
26	t	0	f	1	f	10	3
27	t	1	f	1	f	10	2
31	t	0	f	1	f	11	2
32	t	1	f	2	f	11	2
33	t	2	f	8	f	11	2
37	t	0	f	1	f	52	4
38	t	1	f	2	f	52	4
39	t	2	f	8	f	52	4
43	t	0	f	1	f	53	4
44	t	1	f	2	f	53	4
45	t	2	f	8	f	53	4
49	t	0	f	1	f	55	4
50	t	1	f	2	f	55	4
51	t	2	f	8	f	55	4
55	t	0	f	1	f	56	4
56	t	1	f	2	f	56	4
57	t	2	f	8	f	56	4
61	t	0	f	1	f	57	4
62	t	1	f	2	f	57	4
63	t	2	f	8	f	57	4
67	t	0	f	1	f	58	4
68	t	1	f	2	f	58	4
69	t	2	f	8	f	58	4
73	t	0	f	1	f	59	2
74	t	1	f	2	f	59	2
75	t	2	f	8	f	59	2
79	t	0	f	1	f	129	2
80	t	1	f	2	f	129	2
81	t	2	f	8	f	129	2
85	t	0	f	1	f	130	2
86	t	1	f	2	f	130	2
87	t	2	f	8	f	130	2
91	t	0	f	1	f	131	2
92	t	1	f	2	f	131	2
93	t	2	f	8	f	131	2
97	t	0	f	1	f	132	2
98	t	1	f	2	f	132	2
99	t	2	f	8	f	132	2
\.


--
-- Data for Name: acl_object_identity; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY acl_object_identity (id, object_id_identity, entries_inheriting, parent_object, object_id_class, owner_sid) FROM stdin;
44	33	t	11	8	1
1	1	t	\N	1	1
45	34	t	11	8	1
46	35	t	11	8	1
2	1	t	\N	2	1
3	1	t	2	3	1
47	36	t	11	8	1
48	37	t	11	8	1
4	2	t	2	1	1
5	1	t	\N	4	1
6	1	t	2	5	1
7	2	t	\N	4	1
8	2	t	2	5	1
49	38	t	11	8	1
9	1	t	2	6	1
50	39	t	11	8	1
10	2	t	2	6	1
51	40	t	11	8	1
11	1	t	10	7	1
156	133	t	132	8	1
57	3	t	\N	9	1
157	134	t	132	8	1
58	4	t	\N	9	1
59	2	t	10	7	1
105	86	t	59	8	1
106	87	t	59	8	1
107	88	t	59	8	1
108	89	t	59	8	1
109	90	t	59	8	1
110	91	t	59	8	1
32	21	t	11	8	1
33	22	t	11	8	1
34	23	t	11	8	1
35	24	t	11	8	1
36	25	t	11	8	1
37	26	t	11	8	1
38	27	t	11	8	1
39	28	t	11	8	1
40	29	t	11	8	1
41	30	t	11	8	1
42	31	t	11	8	1
43	32	t	11	8	1
111	92	t	59	8	1
52	3	t	\N	1	1
53	2	t	\N	2	1
54	2	t	53	3	1
112	93	t	59	8	1
55	1	t	\N	9	1
113	94	t	59	8	1
56	2	t	\N	9	1
114	95	t	59	8	1
115	96	t	59	8	1
116	97	t	59	8	1
117	98	t	59	8	1
118	99	t	59	8	1
119	100	t	59	8	1
120	101	t	59	8	1
121	102	t	59	8	1
122	103	t	59	8	1
123	104	t	59	8	1
124	105	t	59	8	1
125	106	t	59	8	1
126	107	t	59	8	1
127	108	t	59	8	1
128	109	t	59	8	1
129	5	t	\N	9	1
130	6	t	\N	9	1
131	7	t	\N	9	1
132	3	t	10	7	1
133	129	t	132	8	1
134	122	t	132	8	1
135	128	t	132	8	1
136	112	t	132	8	1
137	121	t	132	8	1
138	127	t	132	8	1
139	131	t	132	8	1
140	113	t	132	8	1
141	123	t	132	8	1
142	120	t	132	8	1
143	118	t	132	8	1
144	111	t	132	8	1
145	130	t	132	8	1
146	116	t	132	8	1
147	126	t	132	8	1
148	114	t	132	8	1
149	132	t	132	8	1
150	124	t	132	8	1
151	125	t	132	8	1
152	119	t	132	8	1
153	115	t	132	8	1
154	117	t	132	8	1
155	110	t	132	8	1
\.


--
-- Data for Name: acl_sid; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY acl_sid (id, sid, principal) FROM stdin;
1	admin	t
2	neosavvy	t
3	adamparrish	t
4	andre	t
\.


--
-- Data for Name: attribute_descriptor; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY attribute_descriptor (id, type, "precision", description, sort_order, name, valuetype) FROM stdin;
\.


--
-- Data for Name: attribute_enum_value; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY attribute_enum_value (id, sort_order, value, descriptor_id) FROM stdin;
\.


--
-- Data for Name: client_company; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY client_company (id, address_two, postal_code, address_one, state, company_name, city, country, client_user_contact_fk, parent_company_fk) FROM stdin;
1	Suite 101	27713	2224 Sedwick Rd	NC	Neosavvy, Inc.	Durham	\N	1	1
2	Suite 20	10004	11 Broad St	NY	Lab 49 Inc.	New York	\N	2	1
\.


--
-- Data for Name: client_user_contact; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY client_user_contact (id, middle_name, last_name, email_address, contact_phone_number, first_name) FROM stdin;
1	W	Parrish	aparrish@neosavvy.com	9197419597	Adam
2	J	Joshi	djoshi@lab49.com	1 (212) 966 3468	Dhaval
\.


--
-- Data for Name: company; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY company (id, address_one, address_two, postal_code, state, company_name, city, country) FROM stdin;
1	2224 Sedwick Rd	Suite 101	27713	\N	Neosavvy, Inc.	Durham	USA
2	Somewhere	101	88899	\N	Andre's Company	Durham	USA
\.


--
-- Data for Name: company_expense_item_type; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY company_expense_item_type (id, company_fk) FROM stdin;
\.


--
-- Data for Name: company_payment_method; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY company_payment_method (id, company_fk) FROM stdin;
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY databasechangelog (id, author, filename, dateexecuted, md5sum, description, comments, tag, liquibase) FROM stdin;
raw	includeAll	src/main/db/changelogs/init/initial.sql	2011-01-24 02:31:18.304223+00	ac83697ec5589e630acfe23416832cb	Custom SQL		\N	1.9.5
1	tommy	src/main/db/changelogs/init/standardData.xml	2011-01-24 02:31:18.464223+00	6e906a7d1134c14fa3aae29d86fa075	Insert Row (x11), Alter Sequence, Insert Row (x58), Alter Sequence		\N	1.9.5
1	tommy	src/main/db/changelogs/1.0.xml	2011-01-24 02:31:18.504223+00	a4140f764aa9fe80be8a7e982d645b	Create Table		\N	1.9.5
2	tommy	src/main/db/changelogs/1.0.xml	2011-01-24 02:31:18.514223+00	2e58184f1d879f6fd8b13b8710d0462c	Add Not-Null Constraint		\N	1.9.5
3	tommy	src/main/db/changelogs/1.0.xml	2011-01-24 02:31:18.544223+00	6c8fb6aef661f5c26c4c54a0e4b25c24	Drop Table, Create Table		\N	1.9.5
4	adam	src/main/db/changelogs/1.0.xml	2011-01-24 02:31:18.614223+00	10518a5c4833b152ab97d0fa8b4af252	Create Table		\N	1.9.5
5	tommy	src/main/db/changelogs/1.0.xml	2011-01-24 02:31:18.674223+00	17d02b8183b8db56fa71ca8c134fa49	Create Table (x2), Add Foreign Key Constraint (x4)		\N	1.9.5
6	tommy	src/main/db/changelogs/1.0.xml	2011-01-24 02:31:18.694223+00	32e93d79214d9c946e594cbf9cbc56	Add Column, Add Foreign Key Constraint		\N	1.9.5
7	adam	src/main/db/changelogs/1.0.xml	2011-01-24 02:31:18.714223+00	35e536e74f9b25fa44f8f89c8f2f176d	Create Table, Add Foreign Key Constraint (x2)		\N	1.9.5
8	adam	src/main/db/changelogs/1.0.xml	2011-03-02 21:46:26.499261+00	d241325235eb64a4cd96dafcb33157b	Add Column		\N	1.9.5
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
\.


--
-- Data for Name: expense_item_descriptor; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY expense_item_descriptor (id, expense_item_type_fk) FROM stdin;
\.


--
-- Data for Name: expense_item_type; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY expense_item_type (id, type, name, description, sort_order) FROM stdin;
1	STANDARD_EXPENSE_ITEM_TYPE	Advance	Cash Advances made by the employee for cash related purchases	1
2	STANDARD_EXPENSE_ITEM_TYPE	Air & Rail	Air and Rail travel expenses	2
3	STANDARD_EXPENSE_ITEM_TYPE	Auto Parking	Parking related expenses for garage, street, or valet parking	3
4	STANDARD_EXPENSE_ITEM_TYPE	Auto Rental	Car rentals for business travel	4
5	STANDARD_EXPENSE_ITEM_TYPE	Auto tolls	Toll fees	5
6	STANDARD_EXPENSE_ITEM_TYPE	Cell Phone	Personal Cell phone expenses for business use	6
7	STANDARD_EXPENSE_ITEM_TYPE	Computer Supplies		7
8	STANDARD_EXPENSE_ITEM_TYPE	Entertainment		8
9	STANDARD_EXPENSE_ITEM_TYPE	Home Office		9
10	STANDARD_EXPENSE_ITEM_TYPE	Incidentals		10
11	STANDARD_EXPENSE_ITEM_TYPE	Local Transportation		11
12	STANDARD_EXPENSE_ITEM_TYPE	Lodging		12
13	STANDARD_EXPENSE_ITEM_TYPE	Lodging Apartments		13
14	STANDARD_EXPENSE_ITEM_TYPE	Lodging Per Diem		14
15	STANDARD_EXPENSE_ITEM_TYPE	Meals (Actual)		15
16	STANDARD_EXPENSE_ITEM_TYPE	Meals (Per Diem)		16
17	STANDARD_EXPENSE_ITEM_TYPE	Mileage		17
18	STANDARD_EXPENSE_ITEM_TYPE	Office Supplies		18
19	STANDARD_EXPENSE_ITEM_TYPE	Paid on behalf of others		19
20	STANDARD_EXPENSE_ITEM_TYPE	Breakfast		20
21	STANDARD_EXPENSE_ITEM_TYPE	Lunch (Per Diem)		21
22	STANDARD_EXPENSE_ITEM_TYPE	Dinner (Per Diem)		22
23	STANDARD_EXPENSE_ITEM_TYPE	Postage Delivery		23
24	STANDARD_EXPENSE_ITEM_TYPE	Printing Copying		24
25	STANDARD_EXPENSE_ITEM_TYPE	Marketing		25
26	STANDARD_EXPENSE_ITEM_TYPE	Teleconference		26
27	STANDARD_EXPENSE_ITEM_TYPE	Telephone		27
28	STANDARD_EXPENSE_ITEM_TYPE	Education		28
29	STANDARD_EXPENSE_ITEM_TYPE	Miscellaneous		29
\.


--
-- Data for Name: expense_item_value; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY expense_item_value (id, string_value, partition_date, enumerated_value_id, expense_item_fk, descriptor_id) FROM stdin;
\.


--
-- Data for Name: expense_item_value_yy10mm01; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY expense_item_value_yy10mm01 (id, string_value, partition_date, enumerated_value_id, expense_item_fk, descriptor_id) FROM stdin;
\.


--
-- Data for Name: expense_item_value_yy10mm06; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY expense_item_value_yy10mm06 (id, string_value, partition_date, enumerated_value_id, expense_item_fk, descriptor_id) FROM stdin;
\.


--
-- Data for Name: expense_item_value_yy11mm01; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY expense_item_value_yy11mm01 (id, string_value, partition_date, enumerated_value_id, expense_item_fk, descriptor_id) FROM stdin;
\.


--
-- Data for Name: expense_item_value_yy11mm06; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY expense_item_value_yy11mm06 (id, string_value, partition_date, enumerated_value_id, expense_item_fk, descriptor_id) FROM stdin;
\.


--
-- Data for Name: expense_report; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY expense_report (id, state_date, location, end_date, purpose, owner_fk, project_fk, status) FROM stdin;
1	\N	New York City	\N	January 2011 Travel	1	2	APPROVED
2	\N	New York City	\N	February Expenses	1	2	APPROVED
3	\N	NYC	\N	Travel to NY	1	2	APPROVED
\.


--
-- Data for Name: expense_report_audit_history; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY expense_report_audit_history (id, comment, activity_date, user_fk, owner_fk, expense_report_fk) FROM stdin;
\.


--
-- Data for Name: expense_report_item; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY expense_report_item (id, amount, expense_date, comment, expense_report_fk, expense_item_type_fk, payment_method_fk, project_type_fk, receipt_file_ref_fk) FROM stdin;
34	71.00	2011-01-20	\N	1	16	1	3	\N
35	71.00	2011-01-24	\N	1	16	1	3	\N
32	71.00	2011-01-18	\N	1	16	1	3	\N
33	71.00	2011-01-19	\N	1	16	1	3	\N
38	71.00	2011-01-27	\N	1	16	1	3	\N
39	71.00	2011-01-28	\N	1	16	1	3	\N
36	71.00	2011-01-25	\N	1	16	1	3	\N
37	71.00	2011-01-26	\N	1	16	1	3	\N
40	2971.41	2011-01-01	\N	1	13	2	3	\N
21	71.00	2011-01-03	\N	1	16	1	3	\N
23	71.00	2011-01-05	\N	1	16	1	3	\N
22	71.00	2011-01-04	\N	1	16	1	3	\N
25	71.00	2011-01-07	\N	1	16	1	3	\N
24	71.00	2011-01-06	\N	1	16	1	3	\N
27	71.00	2011-01-11	\N	1	16	1	3	\N
26	71.00	2011-01-10	\N	1	16	1	3	\N
29	71.00	2011-01-13	\N	1	16	1	3	\N
28	71.00	2011-01-12	\N	1	16	1	3	\N
31	71.00	2011-01-17	\N	1	16	1	3	\N
30	71.00	2011-01-14	\N	1	16	1	3	\N
102	71.00	2011-02-22	\N	2	16	1	3	\N
103	71.00	2011-02-23	\N	2	16	1	3	\N
100	71.00	2011-02-18	\N	2	16	1	3	\N
101	71.00	2011-02-21	\N	2	16	1	3	\N
98	71.00	2011-02-16	\N	2	16	1	3	\N
99	71.00	2011-02-17	\N	2	16	1	3	\N
96	71.00	2011-02-14	\N	2	16	1	3	\N
97	71.00	2011-02-15	\N	2	15	1	3	\N
108	7.80	2011-02-22	\N	2	11	3	3	\N
109	44.25	2011-02-11	\N	2	8	3	2	\N
106	71.00	2011-02-28	\N	2	16	1	3	\N
107	57.30	2011-02-22	\N	2	11	3	3	\N
104	71.00	2011-02-24	\N	2	16	1	3	\N
105	71.00	2011-02-25	\N	2	16	1	3	\N
87	71.00	2011-02-01	\N	2	16	1	3	\N
86	2983.74	2011-02-01	\N	2	13	2	3	\N
93	71.00	2011-02-09	\N	2	16	1	3	\N
92	71.00	2011-02-08	\N	2	16	1	3	\N
95	71.00	2011-02-11	\N	2	16	1	3	\N
94	71.00	2011-02-10	\N	2	16	1	3	\N
89	71.00	2011-02-03	\N	2	16	1	3	\N
88	71.00	2011-02-02	\N	2	16	1	3	\N
91	71.00	2011-02-07	\N	2	16	1	3	\N
90	71.00	2011-02-04	\N	2	16	1	3	\N
133	2869.30	2011-03-01	\N	3	13	2	3	\N
134	2869.30	2011-03-04	\N	3	13	2	3	\N
129	71.00	2011-03-28	\N	3	16	1	3	\N
122	71.00	2011-03-17	\N	3	16	1	3	\N
128	71.00	2011-03-25	\N	3	16	1	3	\N
112	71.00	2011-03-03	\N	3	16	1	3	\N
121	71.00	2011-03-16	\N	3	16	1	3	\N
127	71.00	2011-03-24	\N	3	16	1	3	\N
131	71.00	2011-03-30	\N	3	16	1	3	\N
113	71.00	2011-03-04	\N	3	16	1	3	\N
123	71.00	2011-03-18	\N	3	16	1	3	\N
120	71.00	2011-03-15	\N	3	16	1	3	\N
118	71.00	2011-03-11	\N	3	16	1	3	\N
111	71.00	2011-03-02	\N	3	16	1	3	\N
130	71.00	2011-03-29	\N	3	16	1	3	\N
116	71.00	2011-03-09	\N	3	16	1	3	\N
126	71.00	2011-03-23	\N	3	16	1	3	\N
114	71.00	2011-03-07	\N	3	16	1	3	\N
132	71.00	2011-03-31	\N	3	16	1	3	\N
124	71.00	2011-03-21	\N	3	16	1	3	\N
125	71.00	2011-03-22	\N	3	16	1	3	\N
119	71.00	2011-03-14	\N	3	16	1	3	\N
115	71.00	2011-03-08	\N	3	16	1	3	\N
117	71.00	2011-03-10	\N	3	16	1	3	\N
110	71.00	2011-03-01	\N	3	16	1	3	\N
\.


--
-- Data for Name: file_refs; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY file_refs (id, type, file_size, created_at, last_modified_at, record_status) FROM stdin;
1	storage_service	2146017	2011-01-26 15:00:45.959+00	2011-01-26 15:01:20.709+00	a
2	storage_service	2146017	2011-01-26 15:01:22.039+00	2011-01-26 15:01:20+00	a
3	storage_service	2263311	2011-01-28 04:11:54.353+00	2011-01-28 04:12:54.793+00	a
4	storage_service	2263311	2011-01-28 04:12:55.883+00	2011-01-28 04:12:54+00	a
5	storage_service	13616	2011-03-13 18:57:19.329+00	2011-03-13 18:57:20.099+00	a
7	storage_service	2785160	2011-03-14 20:14:47.499+00	2011-03-14 20:14:46+00	a
6	storage_service	2785160	2011-03-14 20:14:11.779+00	2011-03-28 02:51:18.707+00	d
\.


--
-- Data for Name: payment_method; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY payment_method (id, type, description, name) FROM stdin;
1	STANDARD	Expense to be reimbursed to employee	Employee Paid
2	STANDARD	Expense will not be reimbursed to employee	Company Paid
3	STANDARD	Expense was on the corporate card and will not be reimbursed	Corp Card
\.


--
-- Data for Name: project; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY project (id, start_date, project_name, end_date, code, parent_company_fk, client_company_fk) FROM stdin;
1	2011-01-01	Team Building 2011	2011-12-31	TM2011	1	1
2	2011-01-01	Morgan Stanley Matrix	2012-08-31	MATRIX	1	2
\.


--
-- Data for Name: project_approvers; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY project_approvers (user_id, project_id) FROM stdin;
\.


--
-- Data for Name: project_participants; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY project_participants (user_id, project_id) FROM stdin;
1	1
2	1
2	2
1	2
\.


--
-- Data for Name: project_payment_method; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY project_payment_method (id, project_fk) FROM stdin;
\.


--
-- Data for Name: project_type; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY project_type (id, type) FROM stdin;
1	Administrative
2	Non-Billable
3	Billable
\.


--
-- Data for Name: role; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY role (id, long_name, short_name) FROM stdin;
1	Company Administrator	ROLE_ADMIN
2	Company Employee	ROLE_EMPLOYEE
\.


--
-- Data for Name: standard_expense_item_type; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY standard_expense_item_type (id) FROM stdin;
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
\.


--
-- Data for Name: standard_payment_method; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY standard_payment_method (id) FROM stdin;
1
2
3
\.


--
-- Data for Name: storage_service_file_refs; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY storage_service_file_refs (id, bucket, file_key, file_name, location, content_type, owner) FROM stdin;
1	receipts	1.jpg	IMG_20110126_100027.jpg	2011/01/26	application/octet-stream	andre
2	receipts	1.jpg	IMG_20110126_100027.jpg	2011/01/26	\N	andre
3	receipts	3.jpg	IMG_20110127_231156.jpg	2011/01/28	application/octet-stream	andre
4	receipts	3.jpg	IMG_20110127_231156.jpg	2011/01/28	\N	andre
5	receipts	5.png	Screen shot 2011-03-08 at 11.15.13 AM.png	2011/03/13	application/octet-stream	neosavvy
6	receipts	6.jpg	IMG_20110314_161411.jpg	2011/03/14	application/octet-stream	neosavvy
7	receipts	6.jpg	IMG_20110314_161411.jpg	2011/03/14	\N	neosavvy
\.


--
-- Data for Name: user_company_role; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY user_company_role (id, role_fk, company_fk, user_fk) FROM stdin;
1	1	1	1
2	2	1	2
3	1	2	3
\.


--
-- Data for Name: user_invite; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY user_invite (id, middle_name, last_name, email_address, contact_phone_number, first_name, registration_token, company_fk) FROM stdin;
1	\N	Parrish	aparrish@neosavvy.com	\N	Adam	D96C5681A8A518F2	1
2	\N	Parrish	aparrish@neosavvy.com	\N	Adam	D258134C7767342A	2
\.


--
-- Data for Name: user_receipts; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY user_receipts (user_fk, receipt_fk) FROM stdin;
3	2
3	4
\.


--
-- Data for Name: user_sessions; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY user_sessions (id, username, creation_date) FROM stdin;
98F75AA2-7FDF-4D90-8CB9-BBAF25962D51	neosavvy	2011-01-24 02:47:17.884+00
A2DEAAC8-2A43-4D25-BE8B-E7A3C911DFAF	adamparrish	2011-01-25 03:37:02.529+00
B8ECBBD5-94BF-4C29-A4A9-FAC94AEBF79E	andre	2011-01-26 14:58:45.324+00
B6C586B0-896B-4FCF-A3E0-C7751476229B	andre	2011-01-26 14:59:58.774+00
5838D18E-4EB7-4FAA-9D8B-F60201DA0A4D	andre	2011-01-28 04:11:31.943+00
60B62B6E-5118-41C8-B443-3A5798D7AB2E	neosavvy	2011-01-29 14:52:21.806+00
8B271E5A-695B-47FC-9A07-754BA3BFAB48	neosavvy	2011-01-31 03:32:49.222+00
12C0273D-8C68-4820-B6AE-F25BD521790B	neosavvy	2011-02-05 23:58:00.406+00
2041ABFC-D1B2-4E23-A830-7CF0C3C3ED2A	neosavvy	2011-02-06 15:20:25.008+00
34AD4372-5FEC-48F9-9378-E2D71CFB757B	neosavvy	2011-02-08 02:36:11.075+00
18795A40-467E-451D-9872-F3B6F6717E68	neosavvy	2011-03-02 22:03:03.333+00
26D6953F-0256-487C-A26E-222C9C8ABD7F	neosavvy	2011-03-03 04:43:43.194+00
578DECA3-0705-4E83-9568-74B3B248EB63	neosavvy	2011-03-11 12:26:53.383+00
6C27D276-08B9-4621-BD38-B1F00DE8904B	neosavvy	2011-03-12 18:52:23.18+00
694D7103-C30A-44EE-BC96-E84004907023	neosavvy	2011-03-14 20:08:56.829+00
30852AB4-3E47-4A47-9C89-1EAB0A6D5454	neosavvy	2011-03-14 20:09:11.129+00
3CB34278-11F0-4299-A7D4-6CD63A27C19F	neosavvy	2011-03-14 20:13:51.579+00
B618BCC7-5A11-4BB4-A51E-00D4ECCC1376	neosavvy	2011-03-20 04:10:36.48+00
AC67246E-CBAC-44F8-A052-93520BBE068A	neosavvy	2011-03-28 02:38:50.667+00
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY users (id, middle_name, last_name, email_address, contact_phone_number, password, username, active, first_name, confirmed_registration, reg_token, password_reset) FROM stdin;
3	de	Cavaignac	aparrish@neosavvy.com	\N	test	andre	t	Andre	t	3AC83FF4B2B0965B	f
2		Parrish	aparrish@neosavvy.com	\N	014B20D2	adamparrish	t	Adam	t	D96C5681A8A518F2	f
1		Parrish	aparrish@neosavvy.com	\N	winter69	neosavvy	t	Adam	t	EAF55BE44C1AEB36	f
\.


--
-- Name: acl_class_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY acl_class
    ADD CONSTRAINT acl_class_pkey PRIMARY KEY (id);


--
-- Name: acl_entry_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY acl_entry
    ADD CONSTRAINT acl_entry_pkey PRIMARY KEY (id);


--
-- Name: acl_object_identity_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY acl_object_identity
    ADD CONSTRAINT acl_object_identity_pkey PRIMARY KEY (id);


--
-- Name: acl_sid_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY acl_sid
    ADD CONSTRAINT acl_sid_pkey PRIMARY KEY (id);


--
-- Name: attribute_descriptor_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY attribute_descriptor
    ADD CONSTRAINT attribute_descriptor_pkey PRIMARY KEY (id);


--
-- Name: attribute_enum_value_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY attribute_enum_value
    ADD CONSTRAINT attribute_enum_value_pkey PRIMARY KEY (id);


--
-- Name: client_company_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY client_company
    ADD CONSTRAINT client_company_pkey PRIMARY KEY (id);


--
-- Name: client_user_contact_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY client_user_contact
    ADD CONSTRAINT client_user_contact_pkey PRIMARY KEY (id);


--
-- Name: company_expense_item_type_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY company_expense_item_type
    ADD CONSTRAINT company_expense_item_type_pkey PRIMARY KEY (id);


--
-- Name: company_payment_method_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY company_payment_method
    ADD CONSTRAINT company_payment_method_pkey PRIMARY KEY (id);


--
-- Name: company_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY company
    ADD CONSTRAINT company_pkey PRIMARY KEY (id);


--
-- Name: expense_item_type_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY expense_item_type
    ADD CONSTRAINT expense_item_type_pkey PRIMARY KEY (id);


--
-- Name: expense_item_value_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY expense_item_value
    ADD CONSTRAINT expense_item_value_pkey PRIMARY KEY (id);


--
-- Name: expense_report_item_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY expense_report_item
    ADD CONSTRAINT expense_report_item_pkey PRIMARY KEY (id);


--
-- Name: expense_report_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY expense_report
    ADD CONSTRAINT expense_report_pkey PRIMARY KEY (id);


--
-- Name: payment_method_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY payment_method
    ADD CONSTRAINT payment_method_pkey PRIMARY KEY (id);


--
-- Name: pk_databasechangelog; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY databasechangelog
    ADD CONSTRAINT pk_databasechangelog PRIMARY KEY (id, author, filename);


--
-- Name: pk_databasechangeloglock; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- Name: pk_expense_report_audit_history; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY expense_report_audit_history
    ADD CONSTRAINT pk_expense_report_audit_history PRIMARY KEY (id);


--
-- Name: pk_file_refs; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY file_refs
    ADD CONSTRAINT pk_file_refs PRIMARY KEY (id);


--
-- Name: pk_user_sessions; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY user_sessions
    ADD CONSTRAINT pk_user_sessions PRIMARY KEY (id);


--
-- Name: project_approvers_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY project_approvers
    ADD CONSTRAINT project_approvers_pkey PRIMARY KEY (user_id, project_id);


--
-- Name: project_participants_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY project_participants
    ADD CONSTRAINT project_participants_pkey PRIMARY KEY (user_id, project_id);


--
-- Name: project_payment_method_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY project_payment_method
    ADD CONSTRAINT project_payment_method_pkey PRIMARY KEY (id);


--
-- Name: project_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY project
    ADD CONSTRAINT project_pkey PRIMARY KEY (id);


--
-- Name: project_type_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY project_type
    ADD CONSTRAINT project_type_pkey PRIMARY KEY (id);


--
-- Name: role_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);


--
-- Name: standard_expense_item_type_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY standard_expense_item_type
    ADD CONSTRAINT standard_expense_item_type_pkey PRIMARY KEY (id);


--
-- Name: standard_payment_method_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY standard_payment_method
    ADD CONSTRAINT standard_payment_method_pkey PRIMARY KEY (id);


--
-- Name: unq_acl_class_0; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY acl_class
    ADD CONSTRAINT unq_acl_class_0 UNIQUE (class);


--
-- Name: unq_acl_entry_0; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY acl_entry
    ADD CONSTRAINT unq_acl_entry_0 UNIQUE (acl_object_identity, ace_order);


--
-- Name: unq_acl_object_identity_0; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY acl_object_identity
    ADD CONSTRAINT unq_acl_object_identity_0 UNIQUE (object_id_class, object_id_identity);


--
-- Name: unq_acl_sid_0; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY acl_sid
    ADD CONSTRAINT unq_acl_sid_0 UNIQUE (sid, principal);


--
-- Name: unq_role_1; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY role
    ADD CONSTRAINT unq_role_1 UNIQUE (short_name);


--
-- Name: unq_users_1; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT unq_users_1 UNIQUE (username);


--
-- Name: user_company_role_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY user_company_role
    ADD CONSTRAINT user_company_role_pkey PRIMARY KEY (id);


--
-- Name: user_invite_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY user_invite
    ADD CONSTRAINT user_invite_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: expense_item_value_yy10mm01_expense_item_id; Type: INDEX; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE INDEX expense_item_value_yy10mm01_expense_item_id ON expense_item_value_yy10mm01 USING btree (expense_item_fk);


--
-- Name: expense_item_value_yy10mm01_partition_date; Type: INDEX; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE INDEX expense_item_value_yy10mm01_partition_date ON expense_item_value_yy10mm01 USING btree (partition_date);


--
-- Name: expense_item_value_yy10mm06_expense_item_id; Type: INDEX; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE INDEX expense_item_value_yy10mm06_expense_item_id ON expense_item_value_yy10mm06 USING btree (expense_item_fk);


--
-- Name: expense_item_value_yy10mm06_partition_date; Type: INDEX; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE INDEX expense_item_value_yy10mm06_partition_date ON expense_item_value_yy10mm06 USING btree (partition_date);


--
-- Name: expense_item_value_yy11mm01_expense_item_id; Type: INDEX; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE INDEX expense_item_value_yy11mm01_expense_item_id ON expense_item_value_yy11mm01 USING btree (expense_item_fk);


--
-- Name: expense_item_value_yy11mm01_partition_date; Type: INDEX; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE INDEX expense_item_value_yy11mm01_partition_date ON expense_item_value_yy11mm01 USING btree (partition_date);


--
-- Name: expense_item_value_yy11mm06_expense_item_id; Type: INDEX; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE INDEX expense_item_value_yy11mm06_expense_item_id ON expense_item_value_yy11mm06 USING btree (expense_item_fk);


--
-- Name: expense_item_value_yy11mm06_partition_date; Type: INDEX; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE INDEX expense_item_value_yy11mm06_partition_date ON expense_item_value_yy11mm06 USING btree (partition_date);


--
-- Name: ix_acl_class_unq_acl_class_0; Type: INDEX; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE INDEX ix_acl_class_unq_acl_class_0 ON acl_class USING btree (class);


--
-- Name: ix_acl_entry_unq_acl_entry_0; Type: INDEX; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE INDEX ix_acl_entry_unq_acl_entry_0 ON acl_entry USING btree (acl_object_identity, ace_order);


--
-- Name: ix_acl_object_identity_unq_acl_object_identity_0; Type: INDEX; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE INDEX ix_acl_object_identity_unq_acl_object_identity_0 ON acl_object_identity USING btree (object_id_class, object_id_identity);


--
-- Name: ix_acl_sid_unq_acl_sid_0; Type: INDEX; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE INDEX ix_acl_sid_unq_acl_sid_0 ON acl_sid USING btree (sid, principal);


--
-- Name: ix_role_unq_role_1; Type: INDEX; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE INDEX ix_role_unq_role_1 ON role USING btree (short_name);


--
-- Name: ix_users_unq_users_1; Type: INDEX; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE INDEX ix_users_unq_users_1 ON users USING btree (username);


--
-- Name: expense_item_value_insert_yy10mm01; Type: RULE; Schema: commonsuser; Owner: commonsuser
--

CREATE RULE expense_item_value_insert_yy10mm01 AS ON INSERT TO expense_item_value WHERE ((new.partition_date >= '2010-01-01'::date) AND (new.partition_date < '2010-06-01'::date)) DO INSTEAD INSERT INTO expense_item_value_yy10mm01 (id, string_value, partition_date, enumerated_value_id, expense_item_fk, descriptor_id) VALUES (new.id, new.string_value, new.partition_date, new.enumerated_value_id, new.expense_item_fk, new.descriptor_id);


--
-- Name: expense_item_value_insert_yy10mm06; Type: RULE; Schema: commonsuser; Owner: commonsuser
--

CREATE RULE expense_item_value_insert_yy10mm06 AS ON INSERT TO expense_item_value WHERE ((new.partition_date >= '2010-06-01'::date) AND (new.partition_date < '2011-01-01'::date)) DO INSTEAD INSERT INTO expense_item_value_yy10mm06 (id, string_value, partition_date, enumerated_value_id, expense_item_fk, descriptor_id) VALUES (new.id, new.string_value, new.partition_date, new.enumerated_value_id, new.expense_item_fk, new.descriptor_id);


--
-- Name: expense_item_value_insert_yy11mm01; Type: RULE; Schema: commonsuser; Owner: commonsuser
--

CREATE RULE expense_item_value_insert_yy11mm01 AS ON INSERT TO expense_item_value WHERE ((new.partition_date >= '2011-01-01'::date) AND (new.partition_date < '2011-06-01'::date)) DO INSTEAD INSERT INTO expense_item_value_yy11mm01 (id, string_value, partition_date, enumerated_value_id, expense_item_fk, descriptor_id) VALUES (new.id, new.string_value, new.partition_date, new.enumerated_value_id, new.expense_item_fk, new.descriptor_id);


--
-- Name: expense_item_value_insert_yy11mm06; Type: RULE; Schema: commonsuser; Owner: commonsuser
--

CREATE RULE expense_item_value_insert_yy11mm06 AS ON INSERT TO expense_item_value WHERE ((new.partition_date >= '2011-06-01'::date) AND (new.partition_date < '2012-01-01'::date)) DO INSTEAD INSERT INTO expense_item_value_yy11mm06 (id, string_value, partition_date, enumerated_value_id, expense_item_fk, descriptor_id) VALUES (new.id, new.string_value, new.partition_date, new.enumerated_value_id, new.expense_item_fk, new.descriptor_id);


--
-- Name: acl_entry_acl_object_identity_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY acl_entry
    ADD CONSTRAINT acl_entry_acl_object_identity_fkey FOREIGN KEY (acl_object_identity) REFERENCES acl_object_identity(id);


--
-- Name: acl_entry_sid_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY acl_entry
    ADD CONSTRAINT acl_entry_sid_fkey FOREIGN KEY (sid) REFERENCES acl_sid(id);


--
-- Name: acl_object_identity_object_id_class_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY acl_object_identity
    ADD CONSTRAINT acl_object_identity_object_id_class_fkey FOREIGN KEY (object_id_class) REFERENCES acl_class(id);


--
-- Name: acl_object_identity_owner_sid_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY acl_object_identity
    ADD CONSTRAINT acl_object_identity_owner_sid_fkey FOREIGN KEY (owner_sid) REFERENCES acl_sid(id);


--
-- Name: acl_object_identity_parent_object_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY acl_object_identity
    ADD CONSTRAINT acl_object_identity_parent_object_fkey FOREIGN KEY (parent_object) REFERENCES acl_object_identity(id);


--
-- Name: attribute_enum_value_descriptor_id_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY attribute_enum_value
    ADD CONSTRAINT attribute_enum_value_descriptor_id_fkey FOREIGN KEY (descriptor_id) REFERENCES attribute_descriptor(id);


--
-- Name: client_company_client_user_contact_fk_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY client_company
    ADD CONSTRAINT client_company_client_user_contact_fk_fkey FOREIGN KEY (client_user_contact_fk) REFERENCES client_user_contact(id);


--
-- Name: client_company_parent_company_fk_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY client_company
    ADD CONSTRAINT client_company_parent_company_fk_fkey FOREIGN KEY (parent_company_fk) REFERENCES company(id);


--
-- Name: company_expense_item_type_company_fk_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY company_expense_item_type
    ADD CONSTRAINT company_expense_item_type_company_fk_fkey FOREIGN KEY (company_fk) REFERENCES company(id);


--
-- Name: company_expense_item_type_id_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY company_expense_item_type
    ADD CONSTRAINT company_expense_item_type_id_fkey FOREIGN KEY (id) REFERENCES expense_item_type(id);


--
-- Name: company_payment_method_company_fk_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY company_payment_method
    ADD CONSTRAINT company_payment_method_company_fk_fkey FOREIGN KEY (company_fk) REFERENCES company(id);


--
-- Name: company_payment_method_id_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY company_payment_method
    ADD CONSTRAINT company_payment_method_id_fkey FOREIGN KEY (id) REFERENCES payment_method(id);


--
-- Name: expense_item_descriptor_expense_item_type_fk_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY expense_item_descriptor
    ADD CONSTRAINT expense_item_descriptor_expense_item_type_fk_fkey FOREIGN KEY (expense_item_type_fk) REFERENCES expense_item_type(id);


--
-- Name: expense_item_descriptor_id_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY expense_item_descriptor
    ADD CONSTRAINT expense_item_descriptor_id_fkey FOREIGN KEY (id) REFERENCES attribute_descriptor(id);


--
-- Name: expense_item_value_descriptor_id_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY expense_item_value
    ADD CONSTRAINT expense_item_value_descriptor_id_fkey FOREIGN KEY (descriptor_id) REFERENCES attribute_descriptor(id);


--
-- Name: expense_item_value_enumerated_value_id_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY expense_item_value
    ADD CONSTRAINT expense_item_value_enumerated_value_id_fkey FOREIGN KEY (enumerated_value_id) REFERENCES attribute_enum_value(id);


--
-- Name: expense_item_value_expense_item_fk_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY expense_item_value
    ADD CONSTRAINT expense_item_value_expense_item_fk_fkey FOREIGN KEY (expense_item_fk) REFERENCES expense_report_item(id);


--
-- Name: expense_report_item_expense_item_type_fk_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY expense_report_item
    ADD CONSTRAINT expense_report_item_expense_item_type_fk_fkey FOREIGN KEY (expense_item_type_fk) REFERENCES expense_item_type(id);


--
-- Name: expense_report_item_expense_report_fk_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY expense_report_item
    ADD CONSTRAINT expense_report_item_expense_report_fk_fkey FOREIGN KEY (expense_report_fk) REFERENCES expense_report(id);


--
-- Name: expense_report_item_payment_method_fk_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY expense_report_item
    ADD CONSTRAINT expense_report_item_payment_method_fk_fkey FOREIGN KEY (payment_method_fk) REFERENCES payment_method(id);


--
-- Name: expense_report_item_project_type_fk_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY expense_report_item
    ADD CONSTRAINT expense_report_item_project_type_fk_fkey FOREIGN KEY (project_type_fk) REFERENCES project_type(id);


--
-- Name: expense_report_owner_fk_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY expense_report
    ADD CONSTRAINT expense_report_owner_fk_fkey FOREIGN KEY (owner_fk) REFERENCES users(id);


--
-- Name: expense_report_project_fk_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY expense_report
    ADD CONSTRAINT expense_report_project_fk_fkey FOREIGN KEY (project_fk) REFERENCES project(id);


--
-- Name: fk_expense_report_audit_history_expense_report_fk; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY expense_report_audit_history
    ADD CONSTRAINT fk_expense_report_audit_history_expense_report_fk FOREIGN KEY (expense_report_fk) REFERENCES expense_report(id);


--
-- Name: fk_expense_report_audit_history_owner_fk; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY expense_report_audit_history
    ADD CONSTRAINT fk_expense_report_audit_history_owner_fk FOREIGN KEY (owner_fk) REFERENCES users(id);


--
-- Name: fk_expense_report_audit_history_user_fk; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY expense_report_audit_history
    ADD CONSTRAINT fk_expense_report_audit_history_user_fk FOREIGN KEY (user_fk) REFERENCES users(id);


--
-- Name: fk_expense_report_item_receipt_file_ref_fk; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY expense_report_item
    ADD CONSTRAINT fk_expense_report_item_receipt_file_ref_fk FOREIGN KEY (receipt_file_ref_fk) REFERENCES file_refs(id);


--
-- Name: fk_receipt_fk; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY user_receipts
    ADD CONSTRAINT fk_receipt_fk FOREIGN KEY (receipt_fk) REFERENCES file_refs(id);


--
-- Name: fk_storage_service_file_refs_id; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY storage_service_file_refs
    ADD CONSTRAINT fk_storage_service_file_refs_id FOREIGN KEY (id) REFERENCES file_refs(id);


--
-- Name: fk_user_fk; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY user_receipts
    ADD CONSTRAINT fk_user_fk FOREIGN KEY (user_fk) REFERENCES users(id);


--
-- Name: project_approvers_project_id_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY project_approvers
    ADD CONSTRAINT project_approvers_project_id_fkey FOREIGN KEY (project_id) REFERENCES project(id);


--
-- Name: project_approvers_user_id_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY project_approvers
    ADD CONSTRAINT project_approvers_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: project_client_company_fk_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY project
    ADD CONSTRAINT project_client_company_fk_fkey FOREIGN KEY (client_company_fk) REFERENCES client_company(id);


--
-- Name: project_parent_company_fk_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY project
    ADD CONSTRAINT project_parent_company_fk_fkey FOREIGN KEY (parent_company_fk) REFERENCES company(id);


--
-- Name: project_participants_project_id_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY project_participants
    ADD CONSTRAINT project_participants_project_id_fkey FOREIGN KEY (project_id) REFERENCES project(id);


--
-- Name: project_participants_user_id_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY project_participants
    ADD CONSTRAINT project_participants_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: project_payment_method_id_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY project_payment_method
    ADD CONSTRAINT project_payment_method_id_fkey FOREIGN KEY (id) REFERENCES payment_method(id);


--
-- Name: project_payment_method_project_fk_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY project_payment_method
    ADD CONSTRAINT project_payment_method_project_fk_fkey FOREIGN KEY (project_fk) REFERENCES project(id);


--
-- Name: standard_expense_item_type_id_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY standard_expense_item_type
    ADD CONSTRAINT standard_expense_item_type_id_fkey FOREIGN KEY (id) REFERENCES expense_item_type(id);


--
-- Name: standard_payment_method_id_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY standard_payment_method
    ADD CONSTRAINT standard_payment_method_id_fkey FOREIGN KEY (id) REFERENCES payment_method(id);


--
-- Name: user_company_role_company_fk_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY user_company_role
    ADD CONSTRAINT user_company_role_company_fk_fkey FOREIGN KEY (company_fk) REFERENCES company(id);


--
-- Name: user_company_role_role_fk_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY user_company_role
    ADD CONSTRAINT user_company_role_role_fk_fkey FOREIGN KEY (role_fk) REFERENCES role(id);


--
-- Name: user_company_role_user_fk_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY user_company_role
    ADD CONSTRAINT user_company_role_user_fk_fkey FOREIGN KEY (user_fk) REFERENCES users(id);


--
-- Name: user_invite_company_fk_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY user_invite
    ADD CONSTRAINT user_invite_company_fk_fkey FOREIGN KEY (company_fk) REFERENCES company(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

