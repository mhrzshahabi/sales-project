package com.nicico.sales.model.enumeration;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

import java.util.*;

@Getter
@RequiredArgsConstructor
public enum EStatus {

    Active(1),
    DeActive(2);

    // ------------------------------------------------------------

    private final Integer id;

    public Integer getValue(EStatus eStatus) {
        return eStatus.id;
    }

    // ------------------------------------------------------------

    public boolean hasStatusFlag(EStatus flag) {

        return getStatusFlags(getId()).contains(flag);
    }

    public static Integer getStatusValue(List<EStatus> flags) {

        return flags != null && flags.size() != 0 ? flags.stream().mapToInt(EStatus::getId).sum() : null;
    }

    public static List<EStatus> getStatusFlags(Integer integer) {

        EStatus[] values = values();
        List<EStatus> result = new ArrayList<>();
        Arrays.sort(values, Collections.reverseOrder(Comparator.comparingInt(EStatus::getId)));
        for (EStatus literal : values) {

            if (literal.getId() > integer) continue;

            result.add(literal);
            integer -= literal.getId();
        }

        return result;
    }
}
