//
//  main.m
//  MapMemory
//
//  Created by pengweijian on 2019/12/12.
//  Copyright © 2019 loyalwind. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "ByMemoryUtils.h"
#include <stdio.h>
#include <map>
#include <string>
#include <iostream>
#include <unordered_map>
#import "MemoryUtilsOC.h"

using namespace std;

void test();
int main(int argc, const char * argv[]) {
    by::MemoryUtils *mgr;
    @autoreleasepool {
        // insert code here...
//        const char *imginfo = "0x0";
//        NSString *p = [@"ssdsad/dsds" stringByAppendingPathComponent:@"abc.png"];
//
//        if (strlen(imginfo)) {
//            NSLog(@"-------");
//        }else{
//            NSLog(@"9999999");
//        }
//        test();
        mgr = by::MemoryUtils::getInstance();
        mgr->setStringForKey("netFlag", "00");
        std::string type = mgr->getStringForKey("netFlag");
        mgr->setStringForKey("netFlag", "33");
        std::string type2 = mgr->getStringForKey("netFlag");
        std::cout<<"type: " << type << type2 << endl;
//        mgr->clearAll();
        
        const char *c = "fssf";
        NSString *cd = @(c);
        [MemoryUtilsOC clearAll];
    }
    std::cout<< mgr << endl;
    return 0;
}

void test()
{
    unordered_map<const char *,float> my_map;
    my_map.insert(make_pair("c++",100.2));
    my_map.insert(make_pair("java",98.3));
    cout<<my_map["java"]<<endl;

    auto itr = my_map.find("java");

    cout<<itr->first<<", "<<itr->second<<endl;

    my_map.erase("java");

    if (my_map.find("java") == my_map.end()){
        cout<<"java not found."<<endl;
    }

    unordered_map<const char *,float>::iterator itr2 = my_map.find("java");
    
//    cout<< itr2 <<endl;
}
