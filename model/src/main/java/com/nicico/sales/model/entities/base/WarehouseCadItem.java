package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.Auditable;
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
@Table(name = "TBL_WAREHOUSE_CAD_ITEM" , indexes = {
    @Index(columnList = "ISSUE_ID", name = "WAREHOUSECADITEM_IDX_ISSUEID")
    })
public class WarehouseCadItem extends Auditable {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_WAREHOUSE_CAD_ITEM")
    @SequenceGenerator(name = "SEQ_WAREHOUSE_CAD_ITEM", sequenceName = "SEQ_WAREHOUSE_CAD_ITEM", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @Column(name = "BUNDLE_SERIAL")
    private String bundleSerial;

    @Column(name = "SHEET_NO")
    private String sheetNo;

    @Column(name = "WEIGHT_KG")
    private Double weightKg;

    @Column(name = "DESCRIPTION")
    private String description;

    @Column(name = "ISSUE_ID")
    private Long issueId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "WAREHOUSE_CAD_ID")
    private WarehouseCad warehouseCad;

    @Setter(AccessLevel.NONE)
    @Column(name = "WAREHOUSE_CAD_ID", insertable = false,updatable = false)
    private Long warehouseCadId;

}