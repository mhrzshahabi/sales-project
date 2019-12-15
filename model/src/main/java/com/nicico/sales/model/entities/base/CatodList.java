package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.Auditable;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.annotations.Subselect;

import javax.persistence.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Subselect("select * from tbl_catod_list")
public class CatodList extends Auditable {

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "base_seq")
	@SequenceGenerator(name = "base_seq", allocationSize = 1)
	@Column(name = "ID")
	private Long id;

	@Column(name = "STOREID")
	private String storeId;

	@Column(name = "TOZINEID")
	private String tozinId;

	@Column(name = "PRODUCTID")
	private String productId;

	@Column(name = "PRODUCTLABEL")
	private String productLabel;

	@Column(name = "WAZN")
	private Long wazn;

	@Column(name = "SHEETNUMBER")
	private Long sheetNumber;

	@Column(name = "PACKINGTYPEID")
	private Long packingTypeId;

	@Column(name = "GDSCODE")
	private Long gdsCode;
}
