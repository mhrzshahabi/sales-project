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
@Table(name = "TBL_GLOSSARY")
public class Glossary extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_GLOSSARY")
    @SequenceGenerator(name = "SEQ_GLOSSARY", sequenceName = "SEQ_GLOSSARY", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @Column(name = "SUMMARY", nullable = false, length = 20)
    private String summary;

    @Column(name = "MEANING", nullable = false, length = 200)
    private String meaning;

}
