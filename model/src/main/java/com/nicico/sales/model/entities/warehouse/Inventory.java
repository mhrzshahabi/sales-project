package com.nicico.sales.model.entities.warehouse;

import com.nicico.sales.model.entities.base.AssayInspection;
import com.nicico.sales.model.entities.base.MaterialItem;
import com.nicico.sales.model.entities.base.WeightInspection;
import com.nicico.sales.model.entities.common.BaseEntity;
import com.nicico.sales.model.entities.contract.Contract2;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.annotations.Formula;
import org.hibernate.annotations.JoinFormula;
import org.hibernate.envers.NotAudited;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
//@SecondaryTable(name = "VIEW_WARH_INVENTORY")
@Table(name = "TBL_WARH_INVENTORY")
public class Inventory extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_WARH_INVENTORY")
    @SequenceGenerator(name = "SEQ_WARH_INVENTORY", sequenceName = "SEQ_WARH_INVENTORY", allocationSize = 1)
    private Long id;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_MATERIAL_ITEM_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "fk_inventory2itemByItemId"))
    private MaterialItem materialItem;

    @NotNull
    @Column(name = "F_MATERIAL_ITEM_ID", nullable = false)
    private Long materialItemId;

    @NotEmpty(message = "شناسه محصول خالی نباشد")
    @Column(name = "C_LABEL", nullable = false, unique = true)
    private String label;

    @OneToMany(mappedBy = "inventory", fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
    private List<RemittanceDetail> remittanceDetails;


    @OneToMany(mappedBy = "inventory", fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
    private List<AssayInspection> assayInspections;


    @ManyToOne(fetch = FetchType.LAZY)
    @JoinFormula(
      "(select weight.id\n" +
              "from TBL_INSPECTION_REPORT ins\n" +
              "         inner join TBL_WEIGHING_INSPECTION weight on ins.ID = weight.F_INSPECTION_REPORT_ID\n" +
              "where\n  ROWNUM<2 and" +
              "      weight.F_INVENTORY_ID = id        AND\n" +
              "      ins.D_ISSUE_DATE =\n" +
              "      (select max(i.D_ISSUE_DATE)\n" +
              "       from TBL_INSPECTION_REPORT i\n" +
              "                inner join TBL_ASSAY_INSPECTION a on i.ID = a.F_INSPECTION_REPORT_ID)\n)"

    )
    private WeightInspection weightInspection;

     @OneToMany(mappedBy = "inventory", fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
        private List<WeightInspection> weightInspections;

    @Formula("(select VIEW_WARH_INVENTORY.weight from VIEW_WARH_INVENTORY where VIEW_WARH_INVENTORY.id=id)")
    private Long weight;
    @Formula("(select VIEW_WARH_INVENTORY.amount from VIEW_WARH_INVENTORY where VIEW_WARH_INVENTORY.id=id)")
    private Long amount;

    @NotAudited
    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "F_CONTRACT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "FK_INVENTORY2CONTRACT2"))
    private Contract2 contract;

    @Column(name = "F_CONTRACT_ID")
    private Long contractId;

}
