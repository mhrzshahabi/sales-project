package com.nicico.sales.model.entities.base;
import com.nicico.sales.model.Auditable;
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
@Table(name = "TBL_CONTRACT_DETAIL")
public class ContractDetail extends Auditable {

    @Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CONTRACT_DETAIL")
	@SequenceGenerator(name = "SEQ_CONTRACT_DETAIL", sequenceName = "SEQ_CONTRACT_DETAIL")
	@Column(name = "ID")
    private Long id;
    @Column(name = "name_ContactAgentSeller", length = 500)
    private String name_ContactAgentSeller;
    @Column(name = "phone_ContactAgentSeller", length = 500)
    private String phone_ContactAgentSeller;
    @Column(name = "mobile_ContactAgentSeller", length = 500)
    private String mobile_ContactAgentSeller;
    @Column(name = "address_ContactAgentSeller", length = 500)
    private String address_ContactAgentSeller;
    @Column(name = "name_ContactContactSeller", length = 500)
    private String name_ContactContactSeller;
    @Column(name = "phone_ContactContactSeller", length = 500)
    private String phone_ContactContactSeller;
    @Column(name = "mobile_ContactContactSeller", length = 500)
    private String mobile_ContactContactSeller;
    @Column(name = "address_ContactContactSeller", length = 500)
    private String address_ContactContactSeller;
    @Column(name = "name_ContactContactAgentBuyer", length = 500)
    private String name_ContactContactAgentBuyer;
    @Column(name = "phone_ContactContactAgentBuyer", length = 500)
    private String phone_ContactContactAgentBuyer;
    @Column(name = "mobile_ContactContactAgentBuyer", length = 500)
    private String mobile_ContactContactAgentBuyer;
    @Column(name = "address_ContactContactAgentBuyer", length = 500)
    private String address_ContactContactAgentBuyer;
    @Column(name = "name_ContactContactBuyer", length = 500)
    private String name_ContactContactBuyer;
    @Column(name = "phone_ContactContactBuyer", length = 500)
    private String phone_ContactContactBuyer;
    @Column(name = "mobile_ContactContactBuyer", length = 500)
    private String mobile_ContactContactBuyer;
    @Column(name = "address_ContactContactBuyer", length = 500)
    private String address_ContactContactBuyer;

    @Column(name = "FEILD_ALL_DEFINITIONS_SAVE", length = 500)
    private String FEILD_ALL_DEFINITIONS_SAVE;





}
