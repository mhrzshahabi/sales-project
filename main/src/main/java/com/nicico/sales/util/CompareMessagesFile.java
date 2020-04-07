package com.nicico.sales.util;

import lombok.RequiredArgsConstructor;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.*;


@RequiredArgsConstructor
@Component
public class CompareMessagesFile {

    private final Environment environment;
    private ResourceBundle resourceBundleEn = ResourceBundle.getBundle("messages_en");
    private ResourceBundle resourceBundleFa = ResourceBundle.getBundle("messages_fa");
    private Map<String, String> messagesEn = Collections.synchronizedMap(new HashMap<>());
    private Map<String, String> messagesFa = Collections.synchronizedMap(new HashMap<>());

    @PostConstruct
    public void compare() throws IOException {
        String UPLOAD_FILE_DIR = environment.getProperty("nicico.upload.dir");
        Enumeration en = resourceBundleEn.getKeys();
        Enumeration fa = resourceBundleFa.getKeys();
        while (en.hasMoreElements()) {
            String key = (String) en.nextElement();
            String value = resourceBundleEn.getString(key);
            messagesEn.put(key, value);
        }
        while (fa.hasMoreElements()) {
            String key = (String) fa.nextElement();
            String value = resourceBundleFa.getString(key);
            messagesFa.put(key, value);
        }

        Set<String> messageFaRemain = new HashSet<>(messagesFa.keySet());
        messageFaRemain.removeAll(messagesEn.keySet());
        Set<String> messageEnRemain = new HashSet<>(messagesEn.keySet());
        messageEnRemain.removeAll(messagesFa.keySet());

        BufferedWriter writer = new BufferedWriter(new FileWriter(UPLOAD_FILE_DIR + "/compareMessagesFile.txt"));
        writer.write("# Date : ****************** " + new Date() + "\r\n");
        writer.write("# Exist in messagesFa but not in messagesEn : " + "\r\n" + messageFaRemain + "\r\n");
        writer.write("# Exist in messagesEN but not in messagesFA : " + "\r\n" + messageEnRemain);
        writer.close();
    }
}
