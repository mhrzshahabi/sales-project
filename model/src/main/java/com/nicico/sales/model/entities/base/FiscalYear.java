package com.nicico.sales.model.entities.base;

import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(schema = "ACCOUNTING", name = "TBL_FISCAL_YEAR")
public class FiscalYear {

    @Transient
    private String resourceName = "FiscalYear";
    @Transient
    private String resourceDesc = "سال مالی";

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "base_seq")
    @SequenceGenerator(name = "base_seq", sequenceName = "ACCOUNTING.SEQ_FISCAL_YEAR_ID")
    @Column(name = "ID", precision = 10)
    private Long id;

    @Column(name = "NAME_FA", nullable = false, length = 100)
    private String nameFA;

    @Column(name = "NAME_EN")
    private String nameEN;

    @Column(name = "FISCAL_CODE")
    private String code;

    @Column(name = "START_DATE")
    private String startDate;

    @Column(name = "END_DATE")
    private String endDate;

    @Column(name = "IS_ACTIVE")
    private Boolean isActive;

    @Column(name = "CREATE_USER")
    private Long createUser;

    @Column(name = "CREATE_DATE")
    private String createDate;

    @Column(name = "EDIT_USER")
    private Long editUser;

    @Column(name = "EDIT_DATE")
    private String editDate;

    //------------------------------------------------------------ to Add auto create and update date ------------------------------------------------
    @Transient
    private String createDateFa;

    @Transient
    private String editDateFA;
}
