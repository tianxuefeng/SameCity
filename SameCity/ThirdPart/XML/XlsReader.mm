//
//  XlsReader.m
//  aiyou
//
//  Created by zengchao on 13-1-25.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "XlsReader.h"
#import "DDXML.h"

#include <stdio.h>
#include "tinyxml.h"
#include <vector>
#import "Province.h"

std::vector<std::vector<TIXML_STRING> >wordVector(const char * xmlName)
{
    std::vector<std::vector<TIXML_STRING> > ivec;
    
    //创建一个XML的文档对象。
    
    TiXmlDocument *myDocument = new TiXmlDocument(xmlName);
    
    myDocument->LoadFile();
    
    //获得根元素，即Persons。
    
    TiXmlElement *RootElement = myDocument->RootElement();

    //输出根元素名称，即输出Persons。
    TiXmlElement * element1 = RootElement->FirstChildElement("Worksheet");
    
    TiXmlElement * element2 = element1->FirstChildElement("Table");
    
    TiXmlElement * element3 = element2->FirstChildElement("Row");
    
    TiXmlElement * memoryRowNodeElement = element3;
    
    while (true)//一共有多少组单词
    {
        if (memoryRowNodeElement == NULL)
        {
            break;
        }
        TiXmlElement * element40;
        
        TiXmlElement * element41 = memoryRowNodeElement->FirstChildElement("Cell");
        
        element40 = element41;
        
        std::vector<TIXML_STRING> tempIvec;
        
        while (true)//一组单词中有多少个元素构成（英文单词,中文解释，记忆方法等）
        {
            if (element41==NULL)
            {
                ivec.push_back(tempIvec);
                break;
            }
            
            TiXmlElement * element42 = element41->FirstChildElement("Data");
            
            TiXmlElement * element43 = element42->FirstChildElement("Font");
            
            if (element43 == NULL)
            {
                
                TIXML_STRING s1(element42->GetText());
                
                tempIvec.push_back(s1);
                
                //  printf("%s\n",s1.c_str());
            }
            else
            {
                TiXmlElement * element53 = element42->FirstChildElement("Font");
                
                TIXML_STRING s2(element53->GetText());
                
                while (true)
                {
                    
                    TiXmlElement * element54 = element53->NextSiblingElement();
                    
                    element53 = element54;
                    
                    if (element54!=NULL)
                    {
                        const char* char1 = element54->GetText();
                        
                        TIXML_STRING tempString(char1);
                        
                        s2 = s2+tempString;
                        // printf("%d\n",(int)element54);
                        
                        // printf("%s\n",s2.c_str());
                    }
                    else
                    {
                        tempIvec.push_back(s2);
                        break;
                    }
                }
            }
            
            element41 = element40->NextSiblingElement("Cell");
            
            element40 = element41;
            
        }
        if (memoryRowNodeElement == NULL)
        {
            break;
        }
        
        TiXmlElement * tempElementRow = memoryRowNodeElement->NextSiblingElement("Row");
        memoryRowNodeElement = tempElementRow;
        
    }
    return ivec;
}

//void traversingVector(std::vector<std::vector<TIXML_STRING> > ivec)
//{
//    for (int i = 0 ; i<ivec.size();i++)
//    {
//        std::vector<TIXML_STRING> tempIvec = ivec[i];
//            
//        for (int j = 0; j<tempIvec.size(); j++)
//        {
//            TIXML_STRING str = tempIvec[j];
//        }
//    }
//}

@implementation XlsReader

+ (void)traversingVector:(NSString *)Name withArr:(NSMutableArray *)xlsArr ofSet:(NSMutableSet *)xlsSet
{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:Name ofType:@"xml"];
    
    if (filePath) {
        const char *char_content = [filePath cStringUsingEncoding:NSASCIIStringEncoding];;
        
        std::vector<std::vector<TIXML_STRING> > ivec = wordVector(char_content);//开始解析
        
        for (int i = 0 ; i<ivec.size();i++)
        {
            std::vector<TIXML_STRING> tempIvec = ivec[i];
            
            if (i==0) {
                continue;
            }
            
            CityDto *city = [[CityDto alloc] init];
            
            for (int j = 0; j<tempIvec.size(); j++)
            {
                TIXML_STRING str = tempIvec[j];
                
                NSString *strValue=[NSString stringWithUTF8String:str.c_str()];
            
                if (j==0) {
                    city.name_p = strValue;
                }
                else if (j==1) {
                    city.pid = strValue;
                }
                else if (j==2) {
                    city.name = strValue;
                }
                else if (j==3){
                    city.enName = strValue;
                }
                else if (j==4) {
                    city.prefixLetter = strValue;
                }
                else if (j==5) {
                    city.cid = strValue;
                }
                else if (j==6) {
                    city.identify = strValue;
                }
            }
            [xlsSet addObject:[NSDictionary dictionaryWithObjectsAndKeys:city.prefixLetter,@"firstLetter", nil]];
            [xlsArr addObject:city];
            RELEASE_SAFELY(city)
        }
    }
}

@end
