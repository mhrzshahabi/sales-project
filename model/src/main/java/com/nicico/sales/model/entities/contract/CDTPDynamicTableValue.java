package com.nicico.sales.model.entities.contract;

import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_CNTR_CDTP_DYNAMIC_TABLE_VALUE"
        , uniqueConstraints = {@UniqueConstraint(columnNames = {"D_ROW_NUM", "F_CONTRACTDETAILVALUE_ID"}, name = "UC_CONTRACTDETAILVALUE_ID_ROW_NUM"),
//        @UniqueConstraint(columnNames = {"C_HEADER_VALUE", "F_CONTRACTDETAILVALUE_ID"}, name = "UC_F_CONTRACTDETAILVALUE_ID_C_HEADER_VALUE")
})
public class CDTPDynamicTableValue extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CNTR_CDTP_DYNAMIC_TABLE_VALUE")
    @SequenceGenerator(name = "SEQ_CNTR_CDTP_DYNAMIC_TABLE_VALUE", sequenceName = "SEQ_CNTR_CDTP_DYNAMIC_TABLE_VALUE", allocationSize = 1)
    private Long id;

    //************************************************************************************************************************************

    @NotNull
    @Column(name = "D_COLNUM", nullable = false)
    @Min(1)
    private Long colNum;

    @NotNull
    @Column(name = "C_HEADER_TYPE", nullable = false)
    private String headerType = "String";

    @NotNull
    @Column(name = "C_HEADER_VALUE", nullable = false)
    private String headerValue;

    @Column(name = "C_HEADER_Key")
    private String headerKey;

    @Column(name = "C_DISPLAY_FIELD")
    private String displayField;

    @NotNull
    @Column(name = "C_VALUE_TYPE", nullable = false)
    private String valueType = "String";

    @Column(name = "B_REQUIRED")
    private Boolean required;

    @Column(name = "C_REGEX_VALIDATOR", length = 2000)
    private String regexValidator;

    @Column(name = "D_MAX_ROWS")
    private Integer maxRows = 0;

    @Column(name = "C_DESCRIPTION", length = 2000)
    private String description;

    @Column(name = "C_INITIAL_CRITERIA", length = 2000)
    private String initialCriteria;

    //************************************************************************************************************************************

//    @Setter(AccessLevel.NONE)
//    @ManyToOne(fetch = FetchType.LAZY)
//    @JoinColumn(name = "F_CDTPDYNAMICTABLE_ID", insertable = false, updatable = false,
//            foreignKey = @ForeignKey(name = "FK_DYNAMIC_TABLE_VALUE2CDTPDYNAMICTABLE"))
//    private CDTPDynamicTable cdtpDynamicTable;
//
//    @NotNull
//    @Column(name = "F_CDTPDYNAMICTABLE_ID", nullable = false)
//    private Long cdtpDynamicTableId;

    @NotNull
    @Column(name = "D_ROW_NUM")
    private Integer rowNum;

    @NotNull
    @Column(name = "C_VALUE", length = 2000)
    private String value;

//    headerValue
//    @NotNull
//    @Column(name = "C_FIELD_NAME", nullable = false)
//    private String fieldName;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_CONTRACTDETAILVALUE_ID", insertable = false, updatable = false,
            foreignKey = @ForeignKey(name = "FK_DYNAMIC_TABLE_VALUE2CCONTRACTDETAILVALUE"))
    private ContractDetailValue contractDetailValue;

    @NotNull
    @Column(name = "F_CONTRACTDETAILVALUE_ID", nullable = false)
    private Long contractDetailValueId;

//    @Column(name = "C_DESCRIPTION", length = 2000)
//    private String description;
}
