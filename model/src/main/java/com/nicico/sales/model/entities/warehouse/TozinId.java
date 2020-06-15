package com.nicico.sales.model.entities.warehouse;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import java.io.Serializable;

@Getter
@Setter
@EqualsAndHashCode(of = {"source","tozinId","nameKala","codeKala","target","cardId"})
@Embeddable
public class TozinId implements Serializable {
    @Column(name = "SOURCEE")
    private String source;
    @Column(name = "TOZINE_ID")
    private String tozinId;
    @Column(name = "GDSNAME")
    private String nameKala;
    @Column(name = "GDSCODE")
    private Long codeKala;
    @Column(name = "TARGET")
    private String target;
    @Column(name = "CARD_ID")
    private String cardId;
}
