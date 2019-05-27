package com.yinhai.ykt.ks.service.impl;

import com.yinhai.core.common.api.util.ValidateUtil;
import com.yinhai.core.common.ta3.dto.TaParamDto;
import com.yinhai.core.service.ta3.domain.service.TaBaseService;
import com.yinhai.ykt.ks.controller.Constant;
import com.yinhai.ykt.ks.service.QuestionManagementService;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;

import java.util.*;

/**
 * @ClassName QuestionManagementServiceImpl
 * @Description TODO
 * @Author zl
 * @Date 2019/5/16 13:15
 * Version 1.0
 **/
public class QuestionManagementServiceImpl extends TaBaseService implements QuestionManagementService {
    @Override
    public void insertA1OrA2(List<Map> list,TaParamDto dto) {
        if (!ValidateUtil.isEmpty(list)) {
            for(Map map : list){
                Integer questionId = (Integer) dao.insert("question.insertQuestion",map);
                Map inMap = new HashMap();
                inMap.put("chapter_id",dto.getAsInteger("chapter_id"));
                inMap.put("question_id",questionId);
                inMap.put("flag",Constant.EFFECTIVE_1);
                dao.insert("question.insert_chapter_question",inMap);//章节试题关系表
                List<String> choice_items = (List<String>) map.get("choice_items");
                Integer right_choice_num = Integer.valueOf((String)map.get("right_choice_num"))-1;
                for(int i = 0;i < choice_items.size();i++){
                    Map item = new HashMap();
                    item.put("qid",questionId);
                    item.put("content",choice_items.get(i));
                    if(right_choice_num == i){
                        item.put("is_right","1");
                    }else{
                        item.put("is_right","0");
                    }
                    Integer id = (Integer) dao.insert("question.insertChoice",item);
                    if("1".equals(item.get("is_right"))){
                        Map map2 = new HashMap();
                        map2.put("question_answer",id.toString());
                        map2.put("question_id",questionId);
                        dao.update("question.updateAnswer",map2);
                    }
                }
            }
        }
    }

    @Override
    public void insertA3(XSSFSheet xssfSheet, TaParamDto dto) {
        String num = "";//同一组父子题标识
        List<Map> subQuestion = new ArrayList<>();//子题的容器
        Integer parId = null;//父题的id
        Integer chapter_id = dto.getAsInteger("chapter_id");//所属章节
        String parOrSub = "";//父子题标识0-父，1-子
        Integer lastRowNum = xssfSheet.getLastRowNum();
        for(int j = 1;j <= lastRowNum;j++){
            XSSFRow row = xssfSheet.getRow(j);
            Iterator<Cell> cells = row.cellIterator();
            Map inMap = new HashMap();//每道题的容器
            List<String> choice_items = new ArrayList<>();//每道题选项的容器
            Cell lastCell = row.getCell(row.getPhysicalNumberOfCells()-1);
            lastCell.setCellType(HSSFCell.CELL_TYPE_STRING);
            while(cells.hasNext()){
                XSSFCell cell = (XSSFCell) cells.next();
                cell.setCellType(HSSFCell.CELL_TYPE_STRING);
                String cell_str = cell.getStringCellValue();
                int index = cell.getColumnIndex();
                if(index == 0){
                    if(ValidateUtil.isEmpty(num)){
                        num = cell_str;
                    }
                    if(!ValidateUtil.isEmpty(num)){
                        if(!num.equals(cell_str)){
                            num = cell_str;
                            //TODO 循环插入子题
                            if(!ValidateUtil.isEmpty(subQuestion)){
                                for(Map map1 : subQuestion){
                                    map1.put("question_pid",parId);
                                    Integer id = (Integer) dao.insert("question.insertQuestion",map1);
                                    List<Map> items = (List<Map>) map1.get("choice_items");
                                    Integer right_choice_num = Integer.valueOf((String)map1.get("right_choice_num"))-1;
                                    for(int i = 0;i < items.size();i++){
                                        Map paramMap = new HashMap();
                                        paramMap.put("qid",id);
                                        paramMap.put("content",items.get(i));
                                        if(right_choice_num == i){
                                            paramMap.put("is_right","1");
                                        }else{
                                            paramMap.put("is_right","0");
                                        }
                                        Integer rightId = (Integer) dao.insert("question.insertChoice",paramMap);
                                        if("1".equals(paramMap.get("is_right"))){
                                            Map map2 = new HashMap();
                                            map2.put("question_answer", rightId);
                                            map2.put("question_id", id);
                                            dao.update("question.updateAnswer", map2);//更新子题的right_answer字段
                                        }
                                    }
                                }
                                Map map3 = new HashMap();
                                map3.put("leaf_num", subQuestion.size());
                                map3.put("question_id", parId);
                                dao.update("question.updateAnswer", map3);//更新父题的leaf_num字段
                                subQuestion.clear();
                            }
                        }
                    }
                }else if( index == 2){
                    inMap.put("question_difficulty",cell_str);
                }else if(index == 3){
                    inMap.put("is_leaf",cell_str);
                    parOrSub = cell_str;
                }else if(index == 4){
                    inMap.put("question_content",cell_str);
                }else if(!(index == row.getPhysicalNumberOfCells()-1 || index == 1 || ValidateUtil.isEmpty(cell_str))){
                    choice_items.add(cell_str);
                }else if(index == row.getPhysicalNumberOfCells()-1){
                    inMap.put("right_choice_num",cell_str);
                }
            }

            if("0".equals(parOrSub)){
                inMap.put("question_typeid",Constant.QUESTIONTYPE_1_A3);
                inMap.put("chapter_id",chapter_id);
                inMap.put("question_tips","");
                inMap.put("question_pid",null);
                inMap.put("leaf_num",0);
                inMap.put("question_level",1);
                inMap.put("audit_state", Constant.AUDIT_STATE_1);
                inMap.put("question_answer","");
                inMap.put("question_explain","");
                inMap.put("user_id",dto.getUser().getUserid());
                inMap.put("flag",Constant.EFFECTIVE_1);
                parId = (Integer) dao.insert("question.insertQuestion",inMap);
                Map inMap1 = new HashMap();
                inMap1.put("chapter_id",chapter_id);
                inMap1.put("question_id",parId);
                inMap1.put("flag",Constant.EFFECTIVE_1);
                dao.insert("question.insert_chapter_question",inMap);//章节试题关系表
            }else if("1".equals(parOrSub)){
                inMap.put("question_typeid",Constant.QUESTIONTYPE_1_A3);
                inMap.put("choice_items",choice_items);
                inMap.put("chapter_id",chapter_id);
                inMap.put("question_tips","");
                inMap.put("question_pid",null);
                inMap.put("leaf_num",0);
                inMap.put("question_level",2);
                inMap.put("audit_state", Constant.AUDIT_STATE_1);
                inMap.put("question_answer","");
                inMap.put("question_explain","");
                inMap.put("user_id",dto.getUser().getUserid());
                inMap.put("flag",Constant.EFFECTIVE_1);
                subQuestion.add(inMap);
            }
        }
        if((!ValidateUtil.isEmpty(subQuestion))){
            for(Map map1 : subQuestion){
                map1.put("question_pid",parId);
                Integer id = (Integer) dao.insert("question.insertQuestion",map1);
                List<Map> items = (List<Map>) map1.get("choice_items");
                Integer right_choice_num = Integer.valueOf((String)map1.get("right_choice_num"))-1;
                for(int i = 0;i < items.size();i++){
                    Map paramMap = new HashMap();
                    paramMap.put("qid",id);
                    paramMap.put("content",items.get(i));
                    if(right_choice_num == i){
                        paramMap.put("is_right","1");
                    }else{
                        paramMap.put("is_right","0");
                    }
                    Integer rightId = (Integer) dao.insert("question.insertChoice",paramMap);
                    if("1".equals(paramMap.get("is_right"))){
                        Map map2 = new HashMap();
                        map2.put("question_answer", rightId);
                        map2.put("question_id", id);
                        dao.update("question.updateAnswer", map2);//更新子题的right_answer字段
                    }
                }
            }
            Map map3 = new HashMap();
            map3.put("leaf_num", subQuestion.size());
            map3.put("question_id", parId);
            dao.update("question.updateAnswer", map3);//更新父题的leaf_num字段
            subQuestion.clear();
        }
    }

    @Override
    public void insertA4(XSSFSheet xssfSheet, TaParamDto dto) {
        String num = "";//同一组父子题标识
        List<Map> subQuestion = new ArrayList<>();//子题的容器
        Integer parId = null;//父题的id
        Integer chapter_id = dto.getAsInteger("chapter_id");//所属章节
        String parOrSub = "";//父子题标识0-父，1-子
        Integer lastRowNum = xssfSheet.getLastRowNum();
        for (int j = 1; j <= lastRowNum; j++) {
            XSSFRow row = xssfSheet.getRow(j);
            Iterator<Cell> cells = row.cellIterator();
            Map inMap = new HashMap();//每道题的容器
            List<String> choice_items = new ArrayList<>();//每道题选项的容器
            Cell lastCell = row.getCell(row.getPhysicalNumberOfCells() - 1);
            lastCell.setCellType(HSSFCell.CELL_TYPE_STRING);
            while (cells.hasNext()) {
                XSSFCell cell = (XSSFCell) cells.next();
                cell.setCellType(HSSFCell.CELL_TYPE_STRING);
                String cell_str = cell.getStringCellValue();
                int index = cell.getColumnIndex();
                if (index == 0) {
                    if (ValidateUtil.isEmpty(num)) {
                        num = cell_str;
                    }
                    if (!ValidateUtil.isEmpty(num)) {
                        if (!num.equals(cell_str)) {
                            num = cell_str;
                            //TODO 循环插入子题
                            if (!ValidateUtil.isEmpty(subQuestion)) {
                                for (Map map1 : subQuestion) {
                                    map1.put("question_pid", parId);
                                    Integer id = (Integer) dao.insert("question.insertQuestion", map1);
                                    List<Map> items = (List<Map>) map1.get("choice_items");
                                    Integer right_choice_num = Integer.valueOf((String) map1.get("right_choice_num")) - 1;
                                    for (int i = 0; i < items.size(); i++) {
                                        Map paramMap = new HashMap();
                                        paramMap.put("qid", id);
                                        paramMap.put("content", items.get(i));
                                        if (right_choice_num == i) {
                                            paramMap.put("is_right", "1");
                                        } else {
                                            paramMap.put("is_right", "0");
                                        }
                                        Integer rightId = (Integer) dao.insert("question.insertChoice", paramMap);
                                        if ("1".equals(paramMap.get("is_right"))) {
                                            Map map2 = new HashMap();
                                            map2.put("question_answer", rightId);
                                            map2.put("question_id", id);
                                            dao.update("question.updateAnswer", map2);//更新子题的right_answer字段
                                        }
                                    }
                                }
                                Map map3 = new HashMap();
                                map3.put("leaf_num", subQuestion.size());
                                map3.put("question_id", parId);
                                dao.update("question.updateAnswer", map3);//更新父题的leaf_num字段
                                subQuestion.clear();
                            }
                        }
                    }
                }else if (index == 2) {
                    inMap.put("question_difficulty", cell_str);
                } else if (index == 3) {
                    inMap.put("is_leaf", cell_str);
                    parOrSub = cell_str;
                } else if (index == 4) {
                    inMap.put("question_content", cell_str);
                } else if (index == 5) {
                    inMap.put("question_tips", cell_str);
                } else if (!(index == row.getPhysicalNumberOfCells() - 1 || index == 1 || ValidateUtil.isEmpty(cell_str))) {
                    choice_items.add(cell_str);
                } else if (index == row.getPhysicalNumberOfCells() - 1) {
                    inMap.put("right_choice_num", cell_str);
                }
            }
            if ("0".equals(parOrSub)) {
                inMap.put("question_typeid", Constant.QUESTIONTYPE_1_A4);
                inMap.put("chapter_id", chapter_id);
                inMap.put("question_tips", "");
                inMap.put("question_pid", null);
                inMap.put("leaf_num", 0);
                inMap.put("question_level", 1);
                inMap.put("audit_state", Constant.AUDIT_STATE_1);
                inMap.put("question_answer", "");
                inMap.put("question_explain", "");
                inMap.put("user_id", dto.getUser().getUserid());
                inMap.put("flag", Constant.EFFECTIVE_1);
                parId = (Integer) dao.insert("question.insertQuestion", inMap);
                Map inMap1 = new HashMap();
                inMap1.put("chapter_id",chapter_id);
                inMap1.put("question_id",parId);
                inMap1.put("flag",Constant.EFFECTIVE_1);
                dao.insert("question.insert_chapter_question",inMap);//章节试题关系表
            } else if ("1".equals(parOrSub)) {
                inMap.put("question_typeid", Constant.QUESTIONTYPE_1_A4);
                inMap.put("choice_items", choice_items);
                inMap.put("chapter_id", chapter_id);
                inMap.put("question_pid", null);
                inMap.put("leaf_num", 0);
                inMap.put("question_level", 2);
                inMap.put("audit_state", Constant.AUDIT_STATE_1);
                inMap.put("question_answer", "");
                inMap.put("question_explain", "");
                inMap.put("user_id", dto.getUser().getUserid());
                inMap.put("flag", Constant.EFFECTIVE_1);
                subQuestion.add(inMap);
            }
        }
        if (!ValidateUtil.isEmpty(subQuestion)) {
            for (Map map1 : subQuestion) {
                map1.put("question_pid", parId);
                Integer id = (Integer) dao.insert("question.insertQuestion", map1);
                List<Map> items = (List<Map>) map1.get("choice_items");
                Integer right_choice_num = Integer.valueOf((String) map1.get("right_choice_num")) - 1;
                for (int i = 0; i < items.size(); i++) {
                    Map paramMap = new HashMap();
                    paramMap.put("qid", id);
                    paramMap.put("content", items.get(i));
                    if (right_choice_num == i) {
                        paramMap.put("is_right", "1");
                    } else {
                        paramMap.put("is_right", "0");
                    }
                    Integer rightId = (Integer) dao.insert("question.insertChoice", paramMap);
                    if ("1".equals(paramMap.get("is_right"))) {
                        Map map2 = new HashMap();
                        map2.put("question_answer", rightId);
                        map2.put("question_id", id);
                        dao.update("question.updateAnswer", map2);//更新子题的right_answer字段
                    }
                }
            }
            Map map3 = new HashMap();
            map3.put("leaf_num", subQuestion.size());
            map3.put("question_id", parId);
            dao.update("question.updateAnswer", map3);//更新父题的leaf_num字段
            subQuestion.clear();
        }
    }

    @Override
    public void insertB1(XSSFSheet xssfSheet,TaParamDto dto){
        String num = "";//同一组父子题标识
        List<Integer> choice_id = new ArrayList<>();//保存选项后的id
        List<Map> subQuestion = new ArrayList<>();//子题的容器
        Integer parId = null;//父题的id
        Integer chapter_id = dto.getAsInteger("chapter_id");//所属章节
        String parOrSub = "";//父子题标识0-父，1-子
        Integer lastRowNum = xssfSheet.getLastRowNum();
        for (int j = 1; j <= lastRowNum; j++) {
            XSSFRow row = xssfSheet.getRow(j);
            Iterator<Cell> cells = row.cellIterator();
            Map inMap = new HashMap();//每道题的容器
            List<String> choice_items = new ArrayList<>();//每道题选项的容器
            Cell lastCell = row.getCell(row.getPhysicalNumberOfCells() - 1);
            lastCell.setCellType(HSSFCell.CELL_TYPE_STRING);
            while (cells.hasNext()) {
                XSSFCell cell = (XSSFCell) cells.next();
                cell.setCellType(HSSFCell.CELL_TYPE_STRING);
                String cell_str = cell.getStringCellValue();
                int index = cell.getColumnIndex();
                if (index == 0) {
                    if (ValidateUtil.isEmpty(num)) {
                        num = cell_str;
                    }
                    if (!ValidateUtil.isEmpty(num)) {
                        if (!num.equals(cell_str)) {
                            num = cell_str;
                            //TODO 循环插入子题
                            if (!ValidateUtil.isEmpty(subQuestion)) {
                                for(Map sub : subQuestion){
                                    sub.put("question_pid",parId);
                                    Integer right_choice_num = Integer.valueOf((String) sub.get("right_choice_num")) - 1;
                                    sub.put("question_answer",choice_id.get(right_choice_num));
                                    dao.insert("question.insertQuestion",sub);
                                }
                                Map map2 = new HashMap();
                                map2.put("leaf_num", subQuestion.size());
                                map2.put("question_id", parId);
                                dao.update("question.updateAnswer", map2);//更新父题的leaf_num字段
                                subQuestion.clear();
                                choice_id.clear();
                            }
                        }
                    }
                } else if (index == 2) {
                    inMap.put("question_difficulty", cell_str);
                } else if (index == 3) {
                    inMap.put("is_leaf", cell_str);
                    parOrSub = cell_str;
                } else if (index == 4) {
                    inMap.put("question_content", cell_str);
                } else if (!(index == row.getPhysicalNumberOfCells() - 1 || index == 1 || ValidateUtil.isEmpty(cell_str))) {
                    choice_items.add(cell_str);
                } else if (index == row.getPhysicalNumberOfCells() - 1) {
                    inMap.put("right_choice_num", cell_str);
                }
            }

            if ("0".equals(parOrSub)) {
                inMap.put("question_typeid", dto.get("question_type"));
                inMap.put("chapter_id", chapter_id);
                inMap.put("question_tips", "");
                inMap.put("question_pid", null);
                inMap.put("leaf_num", 0);
                inMap.put("question_level", 1);
                inMap.put("audit_state", Constant.AUDIT_STATE_1);
                inMap.put("question_answer", "");
                inMap.put("question_explain", "");
                inMap.put("user_id", dto.getUser().getUserid());
                inMap.put("flag", Constant.EFFECTIVE_1);
                parId = (Integer) dao.insert("question.insertQuestion", inMap);
                Map inMap1 = new HashMap();
                inMap1.put("chapter_id",chapter_id);
                inMap1.put("question_id",parId);
                inMap1.put("flag",Constant.EFFECTIVE_1);
                dao.insert("question.insert_chapter_question",inMap);//章节试题关系表
                for(String str : choice_items){
                    Map choice_map = new HashMap();
                    choice_map.put("qid",parId);
                    choice_map.put("content",str);
                    choice_map.put("is_right",null);
                    Integer choiceId = (Integer) dao.insert("question.insertChoice",choice_map);
                    choice_id.add(choiceId);
                }
            } else if ("1".equals(parOrSub)) {
                inMap.put("question_typeid", dto.get("question_type"));
                inMap.put("chapter_id", chapter_id);
                inMap.put("question_tips", "");
                inMap.put("question_pid", null);
                inMap.put("leaf_num", 0);
                inMap.put("question_level", 2);
                inMap.put("audit_state", Constant.AUDIT_STATE_1);
                inMap.put("question_explain", "");
                inMap.put("user_id", dto.getUser().getUserid());
                inMap.put("flag", Constant.EFFECTIVE_1);
                subQuestion.add(inMap);
            }
        }
        if (!ValidateUtil.isEmpty(subQuestion)) {
            for(Map sub : subQuestion){
                sub.put("question_pid",parId);
                Integer right_choice_num = Integer.valueOf((String) sub.get("right_choice_num")) - 1;
                sub.put("question_answer",choice_id.get(right_choice_num));
                dao.insert("question.insertQuestion",sub);
            }
            Map map2 = new HashMap();
            map2.put("leaf_num", subQuestion.size());
            map2.put("question_id", parId);
            dao.update("question.updateAnswer", map2);//更新父题的leaf_num字段
            subQuestion.clear();
            choice_id.clear();
        }
    }

    @Override
    public void insertX(List<Map> list,TaParamDto dto) {
        if (!ValidateUtil.isEmpty(list)) {
            for(Map map : list){
                Integer questionId = (Integer) dao.insert("question.insertQuestion",map);
                Map inMap = new HashMap();
                inMap.put("chapter_id",dto.getAsInteger("chapter_id"));
                inMap.put("question_id",questionId);
                inMap.put("flag",Constant.EFFECTIVE_1);
                dao.insert("question.insert_chapter_question",inMap);//章节试题关系表
                List<String> choice_items = (List<String>) map.get("choice_items");
                List<String> right_choice_num = Arrays.asList(map.get("right_choice_num").toString().split("\\,"));
                Arrays.asList(right_choice_num);
                String right_answers = "";
                for(int i = 0;i < choice_items.size();i++){
                    Map item = new HashMap();
                    item.put("qid",questionId);
                    item.put("content",choice_items.get(i));
                    if(right_choice_num.contains(String.valueOf(i+1))){
                        item.put("is_right","1");
                    }else{
                        item.put("is_right","0");
                    }
                    Integer id = (Integer) dao.insert("question.insertChoice",item);
                    if("1".equals(item.get("is_right"))){
                        right_answers += id+",";
                    }
                }
                right_answers = right_answers.substring(0,right_answers.length()-1);
                Map map2 = new HashMap();
                map2.put("question_answer",right_answers);
                map2.put("question_id",questionId);
                dao.update("question.updateAnswer",map2);
            }
        }
    }

    @Override
    public List<Map> queryChapter() {
        return dao.queryForList("question.queryChapter");
    }


}
