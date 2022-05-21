#! /usr/bin/python3
CNF_UNDEF="#undef"
CNF_ENDIF="#endif"
CNF_ELIF="#elif"
CNF_IF="#if"

import sys
import json
import argparse

def load_cfg( path:str = "memmap_cfg.json" ):
    cfg_dict = None
    with open("memmap_cfg.json","r") as cfg:
        cfg_dict = json.loads(cfg.read())
    return cfg_dict

start_section = lambda name: "START_SEC_%s "%(name)
stop_section = lambda name: "STOP_SEC_%s "%(name)

def create_section( section : str , pragma : str ):
    macro  = "defined %s\n" % ( section )
    macro += "\t\t%s\n" % ( pragma )
    macro += "\t\t%s %s\n" % ( CNF_UNDEF , section )
    macro += "\t\t%s MEMMAP_ERROR\n" % ( CNF_UNDEF )
    return macro

def create_memmap_config( path:str = "memmap_cfg.json" ):
    macro = ""
    cfg = load_cfg()
    sections = cfg["sections"]

    section = sections[0]
    section_macro = section["macro"]
    section_name = section["name"]
    section_pragma = section["pragma"] % section_name
    macro += "\t%s %s" % ( CNF_IF , create_section( start_section( section_macro ) , section_pragma ) )
    for section in sections[1:]:
        section_macro = section["macro"]
        section_name = section["name"]
        section_pragma = section["pragma"] % section_name
        macro += "\t%s %s" % ( CNF_ELIF , create_section( start_section( section_macro ) , section_pragma ) )

    for section in sections:
        section_macro = section["macro"]
        section_name = section["name"]
        section_pragma = section["pragma"] % ""
        macro+= "\t%s %s" % ( CNF_ELIF , create_section( stop_section( section_macro ) , section_pragma ) )
    macro += "\t%s"%CNF_ENDIF
    return macro

def getArgParser():
    parser = None
    if( parser is None ):
        parser = argparse.ArgumentParser( description="MemMap generator", exit_on_error=True)
        parser.add_argument("-c","--config", nargs=1, required=False, help="JSON configuration file" , default=["memmap_cfg.json"], dest="config_file")
        parser.add_argument("-t","--template", nargs=1, required=True, help="MemMap_template.h template file" , default="MemMap_template.h", dest="template_file")
        parser.add_argument("-o","--output", nargs=1, required=True, help="MemMap.h output file" , default="MemMap_output.h", dest="output_file")
    return parser

def main():
    args = getArgParser().parse_args( sys.argv[1:] )
    config_file = args.config_file[0]
    template_file = args.template_file[0]
    output_file = args.output_file[0]
    with open( template_file , "r") as template, open( output_file ,"w") as output:
        macro = create_memmap_config( config_file )
        output.write( template.read() % macro )
    return 0

if __name__ == "__main__":
    try:
        exit(main())
    except Exception as error:
        print(error)
        exit(-1)
