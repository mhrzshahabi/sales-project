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
@Table(name = "TBL_DAILY_REPORT_TRANSPORT")
public class DailyReportTransport extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_DAILY_REPORT_TRANSPORT")
	@SequenceGenerator(name = "SEQ_DAILY_REPORT_TRANSPORT", sequenceName = "DAILY_REPORT_TRANSPORT")
	@Column(name = "ID")
	private Long id;

	@Column(name = "WAREHOUSE_NO", nullable = false, length = 20)
	private String warehouse;

	@Column(name = "TO_DAY", nullable = false, length = 20)
	private String toDay;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "MATERIAL_ID", nullable = false, insertable = false, updatable = false)
	private Material material;

	@Column(name = "MATERIAL_ID")
	private Long materialId;

	@Column(name = "PLANT", nullable = false, length = 100)
	private String plant;

	@Column(name = "PACKING_TYPE", length = 20)
	private String packingType;

	@Column(name = "AMOUNT_DAY")
	private Double amountDay;

	@Column(name = "AMOUNT_FIRST_DAY")
	private Double amountFirstDay;

	@Column(name = "AMOUNT_IMPORT_DAY")
	private Double amountImportDay;

	@Column(name = "AMOUNT_EXPORT_DAY")
	private Double amountExportDay;

	@Column(name = "AMOUNT_REVISE_DAY")
	private Double amountReviseDay;

	@Column(name = "AMOUNT_FIRST_MON")
	private Double amountFirstMon;

	@Column(name = "AMOUNT_IMPORT_MON")
	private Double amountImportMon;

	@Column(name = "AMOUNT_EXPORT_MON")
	private Double amountExportMon;

	@Column(name = "AMOUNT_REVISE_MON")
	private Double amountReviseMon;

	@Column(name = "AMOUNT_FIRST_SAL")
	private Double amountFirstSal;

	@Column(name = "AMOUNT_IMPORT_SAL")
	private Double amountImportSal;

	@Column(name = "AMOUNT_EXPORT_SAL")
	private Double amountExportSal;

	@Column(name = "AMOUNT_REVISE_SAL")
	private Double amountReviseSal;

	@Column(name = "REVISE_SAL_PCT")
	private Double reviseSal;

}
