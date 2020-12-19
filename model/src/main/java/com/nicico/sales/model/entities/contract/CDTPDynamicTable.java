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
@Table(name = "TBL_CNTR_CDTP_DYNAMIC_TABLE",
        uniqueConstraints = {@UniqueConstraint(columnNames = {"D_COLNUM", "F_CDTP_ID"}, name = "UC_C_D_COLNUM_F_CDTP_ID"),
        })
public class CDTPDynamicTable extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CNTR_CDTP_DYNAMIC_TABLE")
    @SequenceGenerator(name = "SEQ_CNTR_CDTP_DYNAMIC_TABLE", sequenceName = "SEQ_CNTR_CDTP_DYNAMIC_TABLE", allocationSize = 1)
    private Long id;

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

    @Column(name = "C_HEADER_TITLE")
    private String headerTitle;

    @Column(name = "C_DISPLAY_FIELD")
    private String displayField;

    @NotNull
    @Column(name = "C_VALUE_TYPE", nullable = false)
    private String valueType = "String";

    @Column(name = "B_REQUIRED")
    private Boolean required;

    @Column(name = "C_REGEX_VALIDATOR", length = 2000)
    private String regexValidator;

    @Column(name = "C_DEFAULT_VALUE", length = 2000)
    private String defaultValue;

    @Column(name = "D_MAX_ROWS")
    private Integer maxRows = 0;

    @Column(name = "C_DESCRIPTION", length = 2000)
    private String description;

    @Column(name = "C_INITIAL_CRITERIA", length = 2000)
    private String initialCriteria;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_CDTP_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "F_DYNAMIC_TABLE2CONTRACT_DTP"))
    private ContractDetailTypeParam cdtp;

    @NotNull
    @Column(name = "F_CDTP_ID", nullable = false)
    private Long cdtpId;
}
