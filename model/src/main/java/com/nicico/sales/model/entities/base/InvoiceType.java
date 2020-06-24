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
@Table( name = "TBL_Invoice_Type")
public class InvoiceType extends Auditable {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE , generator = "SEQ_TBL_Invoice_Type")
    @SequenceGenerator(name = "SEQ_TBL_Invoice_Type" , sequenceName = "SEQ_TBL_Invoice_Type" , allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @Column(name = "TITLE" , nullable = false , length = 80)
    private String title;


}
