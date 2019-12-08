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
@Table(name = "TBL_INVOICE_INTERNAL")
public class InvoiceInternal extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_INVOICE_INTERNAL")
	@SequenceGenerator(name = "SEQ_INVOICE_INTERNAL", sequenceName = "SEQ_INVOICE_INTERNAL")
	@Column(name = "ID", precision = 10)
	private Long id;
	@Column(name = "INV_ID", length = 100)
	private String invId;
	@Column(name = "LCID", length = 100)
	private String lcId;
	@Column(name = "HAVALEHID", length = 100)
	private String havalehId;
	@Column(name = "INV_DATE", length = 30)
	private String invDate;
	@Column(name = "BUYERID", length = 100)
	private String buyerId;
	@Column(name = "CUSTOMERID", length = 100)
	private String customerId;
	@Column(name = "GOODSID", precision = 10)
	private Long goodId;
	@Column(name = "INV_OTHER_KOSORAT", precision = 10)
	private Double invOtherKosorat;
	@Column(name = "HAV_FINALDATE", length = 30)
	private String havFinalDate;
	@Column(name = "WEIGHTREAL", precision = 10)
	private Double weightReal;
	@Column(name = "GHEMATUNIT", precision = 10)
	private Double ghematUnit;
	@Column(name = "TOTALKOSORAT", precision = 10)
	private Double totalKosorat;
	@Column(name = "MABLAGHKOL", precision = 10)
	private Double mablaghKol;
	@Column(name = "SHOMAREHSORATHESAB", length = 255)
	private String shomarehSoratHesab;
	@Column(name = "PAYFORAVAREZMALEYATE", precision = 10)
	private Double payForAvarezMalyat;
	@Column(name = "PAYFORAVAREZALAYANDEGH", precision = 10)
	private Double payForAvarezAlayandegi;
	@Column(name = "INV_SENTED", length = 30)
	private String invSented;
	@Column(name = "TYPEFROSH", precision = 10)
	private Long typeForosh;
	@Column(name = "HAVEALAYANDEGI", precision = 10)
	private Long haveAlayandegi;
	@Column(name = "CODENOSAALAYANDEGI", length = 100)
	private String codeNosaAlayandegi;
	@Column(name = "MARKAZHAZINEHALAYANDEGI", length = 100)
	private String markazHazineAlayandegi;
	@Column(name = "HAVEMALEYATE", precision = 10)
	private Long haveMalyat;
	@Column(name = "CODENOSAMALYATE", length = 100)
	private String codeNosaMalyat;
	@Column(name = "MARKAZHAZINEHMALYATE", length = 100)
	private String markazHazineMalyat;
	@Column(name = "CODENOSABANK", length = 100)
	private String codeNosaBank;
	@Column(name = "CODENOSACUSTOMER", length = 100)
	private String codeNosaCustomer;
	@Column(name = "CODEETEBARENOSACUSTOMER", length = 100)
	private String codeEtebarNosaCustomer;
	@Column(name = "CODEMARKAZHAZINEHCUSTOMER", length = 100)
	private String codeMarkazHazineCustomer;
	@Column(name = "CODEMARKAZHAZINEHLC", length = 100)
	private String codeMarkazHazineHlc;
	@Column(name = "CODENOSAMAHSOL", length = 100)
	private String codeNosaMahsol;
	@Column(name = "CODEMARKAZHAZINEHMAHSOL", length = 100)
	private String codeMarkazHazineMahsol;
	@Column(name = "BANKGROUPDESC", length = 500)
	private String bankGroupDesc;
	@Column(name = "CUST_NAME", length = 500)
	private String customerName;
	@Column(name = "GDSNAME", length = 1000)
	private String gdsName;
	@Column(name = "GRUPGOODSNOSA", length = 100)
	private String groupGoodsNosa;
	@Column(name = "GRUPGOODNAME", length = 1000)
	private String groupGoodName;
	@Column(name = "LC_DATESARRESED", length = 100)
	private String lcDateSarReceid;
	@Column(name = "PROCESSID")
	private String processId;


}