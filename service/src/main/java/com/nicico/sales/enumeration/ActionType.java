package com.nicico.sales.enumeration;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum ActionType {

    Get,
    List,
    Search,
    Create,
    CreateAll,
    Update,
    UpdateAll,
    Delete,
    DeleteAll,
    Unknown;
}