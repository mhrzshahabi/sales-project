package com.nicico.sales.model.entities.base.myModel;

import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Table(name = "TBL_REPORT_DTO")
@Entity
public class ReportDto {
    @Column(name = "WAREHOUSE")
    private String warehouse;
    private String tzn_date;
    private String GDSNAME;
    private String NAMEFA;
    private String PACKNAME;
    @Id
    private Long PMPTYPE_id;
    private Long value;
    @Column(name = "LOADORUNLOAD")
    private Long loadOrUnload;
}
