package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.model.entities.base.Country;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class TozinDTO {
	private Long pId;
	private String cardId;
	private String carNo1;
	private String carNo3;
	private String plak;
	private String carName;
	private String containerId;
	private String containerNo1;
	private String containerNo3;
	private String containerName;
	private String tozinId;
	private String tozinPlantId;
	private Long vazn1;
	private Long vazn2;
	private String condition;
	private Long vazn;
	private Long tedad;
	private Long unitKala;
	private String packName;
	private String haveCode;
	private String date;
	private String tozinDate;
	private String tozinTime;
	private Long codeKala;
	private String nameKala;
	private Long sourceId;
	private String source;
	private Long targetId;
	private String target;
	private String havalehName;
	private String havalehFrom;
	private String havalehTo;
	private String havalehDate;
	private String isFinal;
	private String sourcePlantId;
	private String targetPlantId;

	@NotNull
	@ApiModelProperty(required = true)
	private String tozinName;

	@NotNull
	@ApiModelProperty(required = true)
	private Long countryId;
	@ApiModelProperty(required = true)
	private String tozinCode;
	@ApiModelProperty(required = true)
	private String enTozinName;
	@ApiModelProperty(required = true)
	private String address;
	@ApiModelProperty(required = true)
	private String coreBranch;
	@ApiModelProperty(required = true)
	private Country country;



	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("TozinInfo")
	public static class Info extends TozinDTO {
		private Long id;
		private Date createdDate;
		private String createdBy;
		private Date lastModifiedDate;
		private String lastModifiedBy;
		private Integer version;
	}



	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("TozinCreateRq")
	public static class Create extends TozinDTO {
	}



	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("TozinUpdateRq")
	public static class Update extends TozinDTO {
		@NotNull
		@ApiModelProperty(required = true)
		private Long id;
		@NotNull
		@ApiModelProperty(required = true)
		private Integer version;
	}



	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("TozinDeleteRq")
	public static class Delete {
		@NotNull
		@ApiModelProperty(required = true)
		private List<Long> ids;
	}



	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	@ApiModel("TozinSpecRs")
	public static class TozinSpecRs {
		private SpecRs response;
	}

	// ---------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	public static class SpecRs {
		private List<TozinDTO.Info> data;
		private Integer status;
		private Integer startRow;
		private Integer endRow;
		private Integer totalRows;
	}
}
