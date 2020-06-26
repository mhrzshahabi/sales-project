package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.entities.common.BaseEntity;
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
@Table(name = "TBL_INCOTERMS")
public class Incoterms extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_INCOTERMS")
    @SequenceGenerator(name = "SEQ_INCOTERMS", sequenceName = "SEQ_INCOTERMS", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @Column(name = "CODE", nullable = false)
    private String code;

    @Column(name = "WORKS", nullable = false, length = 10)
    private Boolean works;

    @Column(name = "CARRIER", length = 10)
    private Boolean carrier;

    @Column(name = "ALONGSIDE_SHIP", length = 10)
    private Boolean alongSideShip;

    @Column(name = "ON_BOARD", length = 10)
    private Boolean onBoard;

    @Column(name = "ARRIVAL", length = 10)
    private Boolean arrival;

    @Column(name = "TERMINAL", length = 10)
    private Boolean terminal;

    @Column(name = "DESTINATION", length = 10)
    private Boolean destination;

    @Column(name = "WAREHOUSE", length = 10)
    private Boolean warehouse;

    @Column(name = "EXPENSES", length = 10)
    private String expenses;

    @Column(name = "NAMED_PLACE", length = 10)
    private String namedPlace;

    @Column(name = "NAMED_PORT", length = 10)
    private String namedPort;

}
