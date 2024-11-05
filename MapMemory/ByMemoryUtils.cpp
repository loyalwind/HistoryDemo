//
//  ByMemoryUtils.cpp
//  MapMemory
//
//  Created by loyalwind on 2019/12/12.
//  Copyright © 2019 pengweijian. All rights reserved.
//

#include "ByMemoryUtils.h"
#include <iostream>
using namespace std;
namespace by {

static MemoryUtils *__memoryUtils = nullptr;
MemoryUtils *MemoryUtils::getInstance()
{
    if (__memoryUtils == nullptr) {
       __memoryUtils = new MemoryUtils();
    }
    return __memoryUtils;
}

MemoryUtils::MemoryUtils()
{
    std:string v = m_stringMap["22"];
    std::cout << "MemoryUtils::MemoryUtils()" << std::endl;
}

MemoryUtils::~MemoryUtils()
{
    std::cout << "MemoryUtils::~MemoryUtils()" << std::endl;
}

void MemoryUtils::setStringForKey(const char* key, const std::string &value)
{
    m_stringMap[key] = value;
}

void MemoryUtils::clearStringForKey(const char* key)
{
    map<const char*, std::string>::iterator iter = m_stringMap.find(key);
    if (iter != m_stringMap.end()) {
        m_stringMap.erase(iter);
    }
}

void MemoryUtils::clearAll()
{
    m_stringMap.clear();
}

std::string MemoryUtils::getStringForKey(const char* key, const std::string &defaultValue)
{
    if (m_stringMap.empty()) return defaultValue;
    map<const char*, std::string>::iterator iter = m_stringMap.find(key);
    if (iter == m_stringMap.end()) {
        return defaultValue;
    }else{
        return iter->second;
    }
}

};
