package com.nicico.sales.model.entities.warehouse;

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
@Table(name = "TBL_WARH_TOZIN")
public class TozinTable {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_WARH_TOZIN")
    @SequenceGenerator(name = "SEQ_WARH_TOZIN", sequenceName = "SEQ_WARH_TOZIN", allocationSize = 1)
    private Long id;
    @Column(name = "TOZINE_ID", insertable = false, updatable = false)
    private String tozinId;
    @Column(name = "CARD_ID", insertable = false, updatable = false)
    private String cardId;
    @Column(name = "HAVCODE")
    private String haveCode;
    @Column(name = "TZN_DATE")
    private String tozinDate;
    @Column(name = "SOURCEID")
    private Long sourceId;
    @Column(name = "TARGETID")
    private Long targetId;
}
