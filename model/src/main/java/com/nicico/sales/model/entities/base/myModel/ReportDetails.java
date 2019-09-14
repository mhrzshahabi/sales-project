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
@Table(name="Tbl_Report_Info")
@Entity
public class ReportDetails {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long ID;
    private  Long value;
    private String tzn_date;
    private  Long PMPTYPE_id;
    @Column(name = "LOAD_OR_UNLOAD")
    private  Long loadOrUnload;


}
