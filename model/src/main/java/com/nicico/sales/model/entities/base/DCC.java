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
@Table(name = "TBL_DCC")
public class DCC extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_DCC")
    @SequenceGenerator(name = "SEQ_DCC", sequenceName = "SEQ_DCC", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @Column(name = "c_TBL_NAME1")
    private String tblName1;

    @Column(name = "n_TBL_ID1")
    private Long tblId1;

    @Column(name = "c_TBL_NAME2")
    private String tblName2;

    @Column(name = "n_TBL_ID2")
    private Long tblId2;

    @Column(name = "c_FILE_NAME")
    private String fileName;

    @Column(name = "c_FILE_NEW_NAME")
    private String fileNewName;

    @Column(name = "c_DESCRIPTION", nullable = false, length = 4000)
    private String description;

    @Column(name = "c_DOCUMENT_TYPE", length = 60)
    private String documentType;

}
