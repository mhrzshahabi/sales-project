package com.nicico.sales.model.entities.base.myModel;

import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Table(name = "TBL_REPORT_INFO")
@Entity
public class ReportInfo {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_REPORT_INFO")
    @SequenceGenerator(name = "SEQ_REPORT_INFO", sequenceName = "SEQ_REPORT_INFO_ID", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @Column(name = "VALUE")
    private Long value;

    @Column(name = "TZN_DATE")
    private String tznDate;

    @Column(name = "PMPTYPE_ID")
    private Long PMPTYPE_id;

    @Column(name = "LOAD_OR_UNLOAD")
    private Long loadOrUnload;
}
