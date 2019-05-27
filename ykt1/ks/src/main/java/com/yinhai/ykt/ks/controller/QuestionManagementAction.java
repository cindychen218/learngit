package com.yinhai.ykt.ks.controller;

import com.yinhai.core.app.api.util.ServiceLocator;
import com.yinhai.core.app.ta3.web.controller.BaseController;
import com.yinhai.core.common.api.util.ValidateUtil;
import com.yinhai.core.common.ta3.dto.TaParamDto;
import com.yinhai.ykt.ks.service.QuestionManagementService;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.util.*;

/**
 * @ClassName QuestionManagementAction
 * @Description TODO
 * @Author zl
 * @Date 2019/5/16 10:44
 * Version 1.0
 **/
@RequestMapping("/ks")
@Controller
public class QuestionManagementAction extends BaseController {

    private QuestionManagementService questionManagementService = (QuestionManagementService)ServiceLocator.getService("questionManagementService");

    @RequestMapping("questionManagementAction.do")
    public String excute()throws Exception{
        return "ks/exportQuestions";
    }


    /***
     * 试题批量导入
     * @return
     * @throws Exception
     * cell的读取从0开始
     */
    @RequestMapping(value = "questionManagementAction!batchImport.do",method = RequestMethod.POST)
    public String batchImport(@RequestParam("theFile") MultipartFile theFile){
        InputStream inputStream = null;
        String orgiginalFileName = "";
        List<Map> importFail = new ArrayList<Map>();
        TaParamDto dto = getTaDto();
        try{
            inputStream = theFile.getInputStream();
            orgiginalFileName = theFile.getOriginalFilename();
            String[] strs = orgiginalFileName.split("\\.");
            if(strs[1].equals("xlsx")){
                XSSFWorkbook workbook = new XSSFWorkbook(inputStream);
                for(int i = 0;i < workbook.getNumberOfSheets();i++){
                   XSSFSheet xssfSheet = (XSSFSheet) workbook.getSheetAt(i);
                   if(xssfSheet.getRow(1) == null){
                       continue;
                   }
                   if(i == 1 || i == 7){//A1~A2 || X
                       List<Map> paramList = new ArrayList<>();
                       Integer lastRowNum = xssfSheet.getLastRowNum();
                        for(int j = 1;j <= lastRowNum;j++){
                            Map question = new HashMap();//每道题的容器
                            List<String> choice_items = new ArrayList<>();//每道题选项的容器
                            XSSFRow row = xssfSheet.getRow(j);
                            Cell lastCell = row.getCell(row.getPhysicalNumberOfCells()-1);
                            lastCell.setCellType(HSSFCell.CELL_TYPE_STRING);
                            String right_choice_num = lastCell.getStringCellValue();//正确选项
                            question.put("right_choice_num",right_choice_num);
                            Iterator<Cell> cells = row.cellIterator();
                            while(cells.hasNext()){
                                XSSFCell cell = (XSSFCell) cells.next();
                                cell.setCellType(HSSFCell.CELL_TYPE_STRING);
                                String cell_str = cell.getStringCellValue();
                                int index = cell.getColumnIndex();
                                if(index == 1){
                                    if("A1".equalsIgnoreCase(cell_str)){
                                        question.put("question_typeid",Constant.QUESTIONTYPE_1_A1);
                                    }else if("A2".equalsIgnoreCase(cell_str)){
                                        question.put("question_typeid",Constant.QUESTIONTYPE_1_A2);
                                    }else if("X".equalsIgnoreCase(cell_str)){
                                        question.put("question_typeid",Constant.QUESTIONTYPE_1_X);
                                    }
                                }else if(index == 2){
                                    question.put("question_difficulty",cell_str);
                                }else if(index == 3){
                                    question.put("question_content",cell_str);
                                }else if(!(index == row.getPhysicalNumberOfCells()-1 || index == 0)){
                                    choice_items.add(cell_str);
                                }
                            }
                            question.put("choice_items",choice_items);
                            question.put("question_tips","");
                            question.put("question_pid",null);
                            question.put("is_leaf",1);
                            question.put("leaf_num",0);
                            question.put("question_level",1);
                            question.put("audit_state",Constant.AUDIT_STATE_1);
                            question.put("question_answer","");
                            question.put("question_explain","");
                            question.put("user_id",dto.getUser().getUserid());
                            question.put("flag",Constant.EFFECTIVE_1);
                            paramList.add(question);
                        }
                        if(i == 1){
                            questionManagementService.insertA1OrA2(paramList,dto);
                        }else if(i == 7){
                            questionManagementService.insertX(paramList,dto);
                        }
                   }else if(i == 2){//A3
                       questionManagementService.insertA3(xssfSheet,dto);
                   }else if(i == 3){//A4
                       questionManagementService.insertA4(xssfSheet,dto);
                   }else if(i == 4){//B1
                        dto.put("question_type",Constant.QUESTIONTYPE_1_B1);
                        questionManagementService.insertB1(xssfSheet,dto);
                   }else if(i == 5){//B2
                       dto.put("question_type",Constant.QUESTIONTYPE_1_B2);
                       questionManagementService.insertB1(xssfSheet,dto);
                   }else if(i == 6){//C
                       dto.put("question_type",Constant.QUESTIONTYPE_1_C);
                       questionManagementService.insertB1(xssfSheet,dto);
                   }
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }

        return "JSON";
    }

    @RequestMapping("questionManagementAction!queryChapter.do")
    public String queryChapter()throws Exception{
        List<Map> list = questionManagementService.queryChapter();
        String jsonStr = listToStr(list);
        setData("str",jsonStr);
        return JSON;
    }


    /**
     * 构造树的工具类
     * @return
     * @throws Exception
     */
    public String listToStr(List<Map> list){
        StringBuffer stringBuffer = new StringBuffer();
        stringBuffer.append("[");
        if(!ValidateUtil.isEmpty(list)){
            int size = list.size();
            for(int i = 0;i < size;i++){
                Map<String,Object> map = list.get(i);
                stringBuffer.append("{id:'").append(map.get("id"))
                        .append("',pId:'").append(map.get("pid"))
                        .append("',name:'").append(map.get("name"))
                        .append("',iconSkin:'").append("tree-organisation");
                if("0".equals(map.get("isleaf"))){
                    stringBuffer.append("',isParent:'true'")
                            .append(",iconSkin:'tree-depart-labor'}");
                }else{
                    stringBuffer.append("',isParent:'false'")
                            .append(",iconSkin:'tree-depart-area'}");
                }

                if (i != size-1)
                    stringBuffer.append(",");
            }
        }
        stringBuffer.append("]");
        if(!ValidateUtil.isEmpty(stringBuffer)){
            return stringBuffer.toString();
        }else{
            return null;
        }
    }




}
