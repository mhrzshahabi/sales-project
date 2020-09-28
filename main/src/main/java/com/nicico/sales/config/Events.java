package com.nicico.sales.config;

import com.nicico.sales.event.PostLoadEventListenerImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.beanutils.FluentPropertyBeanIntrospector;
import org.apache.commons.beanutils.PropertyUtils;
import org.hibernate.engine.spi.SessionFactoryImplementor;
import org.hibernate.event.service.spi.EventListenerRegistry;
import org.hibernate.event.spi.EventType;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import javax.persistence.EntityManagerFactory;

@Slf4j
@Component
@RequiredArgsConstructor
public class Events {

    private final EntityManagerFactory factory;

    @PostConstruct
    public void init() {

        SessionFactoryImplementor implementor = this.factory.unwrap(SessionFactoryImplementor.class);
        EventListenerRegistry service = implementor.getServiceRegistry().getService(EventListenerRegistry.class);

        //noinspection unchecked
        service.prependListeners(EventType.POST_LOAD, PostLoadEventListenerImpl.class);

        PropertyUtils.addBeanIntrospector(new FluentPropertyBeanIntrospector());
        log.info("*** PostLoadEventListenerImpl: Listeners are added ***");
    }
}