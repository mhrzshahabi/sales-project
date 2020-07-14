package com.nicico.sales.model.entities.warehouse;


import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;

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
@Table(name = "TBL_WARH_TOZIN")
public class TozinTable extends BaseEntity {
    @Column(name = "B_IS_IN_VIEW", nullable = false, columnDefinition = "number default 1")
    private final Boolean isInView = true;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_WARH_TOZIN")
    @SequenceGenerator(name = "SEQ_WARH_TOZIN", sequenceName = "SEQ_WARH_TOZIN", allocationSize = 1)
    private Long id;
    @NotEmpty
    @Column(name = "TOZINE_ID", nullable = false, unique = true)
    private String tozinId;
    @Column(name = "SOURCEID", nullable = false)
    private Long sourceId;
    @Column(name = "TARGETID", nullable = false)
    private Long targetId;
    @Column(name = "CARD_ID")
    private String cardId;
    @Column(name = "HAVCODE")
    private String haveCode;
    @Column(name = "WAZN", nullable = false)
    private Long vazn;
    @Column(name = "DAT", nullable = false)
    private String date;
    @Column(name = "CTRL_DESC_OUT", length = 1000)
    private String ctrlDescOut;
    @Column(name = "PLAK", nullable = false)
    private String plak;
    @Column(name = "DRVNAME", nullable = false)
    private String driverName;
    @NotNull
    @Column(name = "GDSCODE", nullable = false)
    private Long codeKala;
    @Column(name = "CONTENER_NO3")
    private String containerNo3;
    @OneToMany(mappedBy = "destinationTozin", fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
    private List<RemittanceDetail> remittanceDetailsAsDestination;

    @OneToMany(mappedBy = "sourceTozin", fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
    private List<RemittanceDetail> remittanceDetailsAsSource;

}
