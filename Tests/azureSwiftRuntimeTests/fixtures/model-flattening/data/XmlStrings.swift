//
//  XmlStrings.swift
//  azureSwiftRuntime
//
//  Created by Vladimir Shcherbakov on 1/16/18.
//

let xmlResourceCollection =
"""
<ResourceCollection>
    <dictionaryofresources>
        <Product1>
            <id>1</id>
            <location>Building 44</location>
            <name>Resource1</name>
            <properties>
                <provisioningState>Succeeded</provisioningState>
                <provisioningStateValues>OK</provisioningStateValues>
                <p.name>Product1</p.name>
                <type>Flat</type>
            </properties>
            <tags>
                <tag1>value1</tag1>
                <tag2>value3</tag2>
            </tags>
            <type>Microsoft.Web/sites</type>
        </Product1>
        <Product2>
            <id>2</id>
            <name>Resource2</name>
            <location>Building 44</location>
        </Product2>
        <Product3>
            <id>3</id>
            <name>Resource3</name>
        </Product3>
    </dictionaryofresources>
    <arrayofresources>
        <resource>
            <id>4</id>
            <location>Building 44</location>
            <name>Resource4</name>
            <properties>
                <provisioningState>Succeeded</provisioningState>
                <provisioningStateValues>OK</provisioningStateValues>
                <p.name>Product4</p.name>
                <type>Flat</type>
            </properties>
            <tags>
                <tag1>value1</tag1>
                <tag2>value3</tag2>
            </tags>
            <type>Microsoft.Web/sites</type>
        </resource>
        <resource>
            <id>5</id>
            <name>Resource5</name>
            <location>Building 44</location>
        </resource>
        <resource>
            <id>6</id>
            <name>Resource6</name>
        </resource>
    </arrayofresources>
    <productresource>
        <id>7</id>
        <name>Resource7</name>
        <location>Building 44</location>
    </productresource>
</ResourceCollection>
"""

let xmlDictionary =
"""
<Dictionary>
<Product1>
<id>1</id>
<location>Building 44</location>
<name>Resource1</name>
<properties>
<provisioningState>Succeeded</provisioningState>
<provisioningStateValues>OK</provisioningStateValues>
<p.name>Product1</p.name>
<type>Flat</type>
</properties>
<tags>
<tag1>value1</tag1>
<tag2>value3</tag2>
</tags>
<type>Microsoft.Web/sites</type>
</Product1>
<Product2>
<id>2</id>
<name>Resource2</name>
<location>Building 44</location>
</Product2>
<Product3>
<id>3</id>
<name>Resource3</name>
</Product3>
</Dictionary>
"""

let xmlArray =
"""
<Array>
<item>
<id>1</id>
<location>Building 44</location>
<name>Resource1</name>
<properties>
<provisioningState>Succeeded</provisioningState>
<provisioningStateValues>OK</provisioningStateValues>
<p.name>Product1</p.name>
<type>Flat</type>
</properties>
<tags>
<tag1>value1</tag1>
<tag2>value3</tag2>
</tags>
<type>Microsoft.Web/sites</type>
</item>
<item>
<id>2</id>
<name>Resource2</name>
<location>Building 44</location>
</item>
<item>
<id>3</id>
<name>Resource3</name>
</item>
</Array>
"""

