package com.nicico.sales.model.entities.contract;

import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_CNTR_CDTP_DYNAMIC_TABLE_VALUE"
        , uniqueConstraints = {@UniqueConstraint(columnNames = {"D_ROW_NUM", "F_CDTPDYNAMICTABLE_ID","F_CONTRACTDETAILVALUE_ID"}, name = "UC_TBL_CNTR_CDTP_DYNAMIC_TABLE_VALUE_ROW_NUM_F_CDTPDYNAMICTABLE_ID"),
//        @UniqueConstraint(columnNames = {"C_HEADER_VALUE", "F_CDTP_ID"}, name = "UC_C_D_COLNUM_F_CDTP_ID")
}
)
public class CDTPDynamicTableValue extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CNTR_CDTP_DYNAMIC_TABLE_VALUE")
    @SequenceGenerator(name = "SEQ_CNTR_CDTP_DYNAMIC_TABLE_VALUE", sequenceName = "SEQ_CNTR_CDTP_DYNAMIC_TABLE_VALUE", allocationSize = 1)
    private Long id;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_CDTPDYNAMICTABLE_ID", insertable = false, updatable = false,
            foreignKey = @ForeignKey(name = "FK_DYNAMIC_TABLE_VALUE2CDTPDYNAMICTABLE"))
    private CDTPDynamicTable cdtpDynamicTable;

    @NotNull
    @Column(name = "F_CDTPDYNAMICTABLE_ID", nullable = false)
    private Long cdtpDynamicTableId;

    @NotNull
    @Column(name = "D_ROW_NUM")
    private Integer rowNum;

    @NotNull
    @Column(name = "C_VALUE", length = 2000)
    private String value;

    @NotNull
    @Column(name = "C_FIELD_NAME", nullable = false)
    private String fieldName;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_CONTRACTDETAILVALUE_ID", insertable = false, updatable = false,
            foreignKey = @ForeignKey(name = "FK_DYNAMIC_TABLE_VALUE2CCONTRACTDETAILVALUE"))
    private ContractDetailValue contractDetailValue;

    @NotNull
    @Column(name = "F_CONTRACTDETAILVALUE_ID", nullable = false)
    private Long contractDetailValueId;

    @Column(name = "C_DESCRIPTION", length = 2000)
    private String description;

}
