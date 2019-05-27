package com.yinhai.ykt.ks.service;


import com.yinhai.core.common.ta3.dto.TaParamDto;
import com.yinhai.core.domain.api.domain.service.IService;
import org.apache.poi.xssf.usermodel.XSSFSheet;

import java.util.List;
import java.util.Map;
public interface QuestionManagementService extends IService {

    public void insertA1OrA2(List<Map> list,TaParamDto dto);

    public void insertA3(XSSFSheet xssfSheet, TaParamDto dto);

    public void insertA4(XSSFSheet xssfSheet,TaParamDto dto);

    public void insertB1(XSSFSheet xssfSheet,TaParamDto dto);

    public void insertX(List<Map> list,TaParamDto dto);

    public List<Map> queryChapter();
}
