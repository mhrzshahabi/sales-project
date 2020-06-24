INSERT INTO TBL_WARH_REMITTANCE_TYPE (ID, C_CREATED_BY, D_CREATED_DATE, C_LAST_MODIFIED_BY,
                                                 D_LAST_MODIFIED_DATE, N_VERSION, N_E_STATUS, B_EDITABLE, C_DESCRIPTION,
                                                 C_NAME)
VALUES (SEQ_WARH_REMITTANCE_TYPE.nextval, 'saeb',
        TO_TIMESTAMP('2020-05-06 08:49:21.000000', 'YYYY-MM-DD HH24:MI:SS.FF6'), null, null, 0, default, default, null,
        'ورود به انبار');
INSERT INTO TBL_WARH_REMITTANCE_TYPE (ID, C_CREATED_BY, D_CREATED_DATE, C_LAST_MODIFIED_BY,
                                                 D_LAST_MODIFIED_DATE, N_VERSION, N_E_STATUS, B_EDITABLE, C_DESCRIPTION,
                                                 C_NAME)
VALUES (SEQ_WARH_REMITTANCE_TYPE.nextval, 'saeb',
        TO_TIMESTAMP('2020-05-06 08:49:21.000000', 'YYYY-MM-DD HH24:MI:SS.FF6'), null, null, 0, default, default, null,
        'خروج جهت فروش');
INSERT INTO TBL_WARH_REMITTANCE_TYPE (ID, C_CREATED_BY, D_CREATED_DATE, C_LAST_MODIFIED_BY,
                                                 D_LAST_MODIFIED_DATE, N_VERSION, N_E_STATUS, B_EDITABLE, C_DESCRIPTION,
                                                 C_NAME)
VALUES (SEQ_WARH_REMITTANCE_TYPE.nextval, 'saeb',
        TO_TIMESTAMP('2020-05-06 08:49:21.000000', 'YYYY-MM-DD HH24:MI:SS.FF6'), null, null, 0, default, default, null,
        'انتقال به انبار');

commit;

