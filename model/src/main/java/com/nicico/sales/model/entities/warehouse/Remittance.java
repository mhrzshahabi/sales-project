package com.nicico.sales.model.entities.warehouse;

import com.nicico.sales.model.entities.base.Port;
import com.nicico.sales.model.entities.base.Shipment;
import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.annotations.Formula;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_WARH_REMITTANCE")
public class Remittance extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_WARH_REMITTANCE")
    @SequenceGenerator(name = "SEQ_WARH_REMITTANCE", sequenceName = "SEQ_WARH_REMITTANCE", allocationSize = 1)
    private Long id;

    @NotNull
    @Column(name = "C_CODE", nullable = false, unique = true)
    private String code;

    @OneToMany(mappedBy = "remittance", fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
    @OrderBy("date")
    private List<RemittanceDetail> remittanceDetails;

    @Column(name = "C_DESCRIPTION", length = 1000)
    private String description;

    @ManyToOne(fetch = FetchType.LAZY)
    @Setter(AccessLevel.NONE)
    @JoinColumn(
            name = "F_shipment_id",
            foreignKey = @ForeignKey(name = "FK_remittance_to_shipment"),
            insertable = false,
            updatable = false
    )
    private Shipment shipment;

    //    @NotNull
    @Column(name = "F_shipment_id")
    private Long shipmentId;

    @Formula("(select nvl(dtozin.dat,stozin.DAT) from TBL_WARH_REMITTANCE_DETAIL rd " +
            "left join TBL_WARH_TOZIN dtozin on rd.F_DESTINATION_TOZINE_ID = dtozin.ID " +
            "inner join TBL_WARH_TOZIN stozin on rd.F_SOURCE_TOZINE_ID = stozin.ID " +
            "where rd.F_REMITTANCE_ID=id and ROWNUM=1 )")
    private String date;

}
