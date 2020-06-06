package com.nicico.sales.model.entities.base;





import com.nicico.sales.model.Auditable;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.Getter;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Id;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.SequenceGenerator;
import javax.persistence.Column;


@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_Analyse_Product_MO")
public class AnalysisMo extends Auditable {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE , generator = "SEQ_Analyse_Product_MO")
    @SequenceGenerator(name = "SEQ_Analyse_Product_MO" , sequenceName = "SEQ_Analyse_Product_MO" , allocationSize = 1)
    @Column(name = "ID")
    private Long id;


    @Column(name = "LOT_NAME" , nullable = false , length = 40)
    private String lotName;

    @Column(name = "MO")
    private Double mo;

    @Column(name = "CU")
    private Double cu;

    @Column(name = "SI")
    private Double si;

    @Column(name = "PB")
    private Double pb;

    @Column(name = "S")
    private Double s;

    @Column(name = "C")
    private Double c;

    @Column(name = "P")
    private Double p;
}

