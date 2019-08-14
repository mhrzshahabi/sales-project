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
@Table(name = "view_tozin_s", schema = "SALES")
public class TozinSales extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "base_seq")
	@SequenceGenerator(name = "base_seq")
	@Column(name = "ID", precision = 10)
	private Long id;

	@Column(name = "PID", precision = 10)
	private Long pId;
	@Column(name = "CARD_ID")
	private String cardId;
	@Column(name = "CARNO1")
	private String carNo1;
	@Column(name = "CARNO3")
	private String carNo3;
	@Column(name = "PLAK")
	private String plak;
	@Column(name = "CARNAME")
	private String carName;
	@Column(name = "CUSTOMERID")
	private String customerId;
	@Column(name = "CUSTOMER")
	private String customer;
	@Column(name = "SELLERID")
	private String sellerId;
	@Column(name = "SELLER")
	private String seller;
	@Column(name = "TOZINE_ID")
	private String tozinId;
	@Column(name = "tozin_plant_id")
	private String tozinPlantId;
	@Column(name = "WAZN1")
	private Long vazn1;
	@Column(name = "WAZN2")
	private Long vazn2;
	@Column(name = "CONDITION")
	private String condition;
	@Column(name = "WAZN")
	private Long vazn;
	@Column(name = "TEDAD")
	private Long tedad;
	@Column(name = "UNIT_KALA")
	private Long unitKala;
	@Column(name = "PACKNAME")
	private String packName;
	@Column(name = "HAVCODE")
	private String haveCode;
	@Column(name = "DAT")
	private String date;
	@Column(name = "TZN_DATE")
	private String tozinDate;
	@Column(name = "TZN_TIME")
	private String tozinTime;
	@Column(name = "GDSCODE")
	private Long codeKala;
	@Column(name = "GDSNAME")
	private String nameKala;
	@Column(name = "SOURCEID")
	private Long sourceId;
	@Column(name = "SOURCEE")
	private String source;
	@Column(name = "TARGETID")
	private Long targetId;
	@Column(name = "TARGET")
	private String target;
	@Column(name = "HAV_NAME")
	private String havalehName;
	@Column(name = "HAV_DATE")
	private String havalehDate;
	@Column(name = "HAV_ISFINAL")
	private String isFinal;
	@Column(name = "source_plant_id")
	private String sourcePlantId;
	@Column(name = "target_plant_id")
	private String targetPlantId;
}