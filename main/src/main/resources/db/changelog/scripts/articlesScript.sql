DECLARE
    seq_dynamic_table   NUMBER;
    seq_type_param      NUMBER;
BEGIN
    FOR record IN (
        SELECT
            *
        FROM
            --SOURCE    
            dev_sales.tbl_cntr_contract_detail_type
        --WHICH DATA FROM SOURCE        
        WHERE
            f_material_id = 1
    ) LOOP
        --DESTINATION
        INSERT INTO saleslocal.tbl_cntr_contract_detail_type (
            id,
            c_created_by,
            d_created_date,
            c_last_modified_by,
            d_last_modified_date,
            n_version,
            n_e_status,
            b_editable,
            c_code,
            f_material_id,
            c_title_en,
            c_title_fa
        ) VALUES (
            --SOURCE
            dev_sales.seq_cntr_contract_detail_type.nextval,
            record.c_created_by,
            record.d_created_date,
            record.c_last_modified_by,
            record.d_last_modified_date,
            record.n_version,
            record.n_e_status,
            record.b_editable,
            record.c_code,
            record.f_material_id,
            record.c_title_en,
            record.c_title_fa
        );

        FOR record_param IN (
            SELECT
                *
            FROM
                --SOURCE    
                dev_sales.tbl_cntr_contract_detail_type_param
            WHERE
                f_contract_detail_type_id = record.id
        ) LOOP
            --SOURCE
            seq_type_param := dev_sales.seq_cntr_contract_detail_type_param.nextval;
            
            --DESTINATION
            INSERT INTO saleslocal.tbl_cntr_contract_detail_type_param (
                id,
                c_created_by,
                d_created_date,
                c_last_modified_by,
                d_last_modified_date,
                n_version,
                n_e_status,
                b_editable,
                f_contract_detail_type_id,
                c_default_value,
                c_key,
                c_name,
                c_reference,
                b_required,
                n_type,
                f_unit_id
            ) VALUES (
                seq_type_param,
                record_param.c_created_by,
                record_param.d_created_date,
                record_param.c_last_modified_by,
                record_param.d_last_modified_date,
                record_param.n_version,
                record_param.n_e_status,
                record_param.b_editable,
                --SOURCE
                dev_sales.seq_cntr_contract_detail_type.currval,
                record_param.c_default_value,
                record_param.c_key,
                record_param.c_name,
                record_param.c_reference,
                record_param.b_required,
                record_param.n_type,
                record_param.f_unit_id
            );

            FOR record_dynamic IN (
                SELECT
                    *
                FROM
                    --SOURCE    
                    dev_sales.tbl_cntr_cdtp_dynamic_table
                WHERE
                    f_cdtp_id = record_param.id
            ) LOOP
                --DESTINATION
                INSERT INTO saleslocal.tbl_cntr_cdtp_dynamic_table (
                    id,
                    c_created_by,
                    d_created_date,
                    c_last_modified_by,
                    d_last_modified_date,
                    n_version,
                    n_e_status,
                    b_editable,
                    f_cdtp_id,
                    d_colnum,
                    c_default_value,
                    c_description,
                    c_header_type,
                    c_header_value,
                    d_max_rows,
                    c_regex_validator,
                    b_required,
                    c_value_type,
                    c_header_key,
                    c_initial_criteria,
                    c_display_field,
                    c_header_title
                ) VALUES (
                    --SOURCE
                    dev_sales.seq_cntr_cdtp_dynamic_table.nextval,
                    record_dynamic.c_created_by,
                    record_dynamic.d_created_date,
                    record_dynamic.c_last_modified_by,
                    record_dynamic.d_last_modified_date,
                    record_dynamic.n_version,
                    record_dynamic.n_e_status,
                    record_dynamic.b_editable,
                    seq_type_param,
                    record_dynamic.d_colnum,
                    record_dynamic.c_default_value,
                    record_dynamic.c_description,
                    record_dynamic.c_header_type,
                    record_dynamic.c_header_value,
                    record_dynamic.d_max_rows,
                    record_dynamic.c_regex_validator,
                    record_dynamic.b_required,
                    record_dynamic.c_value_type,
                    record_dynamic.c_header_key,
                    record_dynamic.c_initial_criteria,
                    record_dynamic.c_display_field,
                    record_dynamic.c_header_title
                );

            END LOOP;

        END LOOP;

        FOR record_template IN (
            SELECT
                *
            FROM
                --SOURCE    
                dev_sales.tbl_cntr_contract_detail_type_template
            WHERE
                f_contract_detail_type_id = record.id
        ) LOOP
            --DESTINATION
            INSERT INTO saleslocal.tbl_cntr_contract_detail_type_template (
                id,
                c_created_by,
                d_created_date,
                c_last_modified_by,
                d_last_modified_date,
                n_version,
                n_e_status,
                b_editable,
                c_code,
                c_content,
                f_contract_detail_type_id
            ) VALUES (
                --SOURCE
                dev_sales.seq_cntr_contract_detail_type_template.nextval,
                record_template.c_created_by,
                record_template.d_created_date,
                record_template.c_last_modified_by,
                record_template.d_last_modified_date,
                record_template.n_version,
                record_template.n_e_status,
                record_template.b_editable,
                record_template.c_code,
                record_template.c_content,
                --SOURCE
                dev_sales.seq_cntr_contract_detail_type.currval
            );

        END LOOP;

    END LOOP;
END;