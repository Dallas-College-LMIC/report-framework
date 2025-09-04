# /rf-create-report-spec - Generate Data Specification from Stakeholder Request

## Purpose
Analyzes stakeholder request documents and generates comprehensive data specifications for report creation, using pyghtcast (Lightcast API) and censusdis-cli to intelligently identify relevant data sources and create structured queries.

## Usage
```
/rf-create-report-spec <request_file_path>
```

**Parameters:**
- `request_file_path`: Path to stakeholder request document (PDF, DOCX, TXT, MD)

## Behavioral Instructions

**Core Principle: Minimum Viable Specification**
- Focus on data needed to answer the core question
- Avoid comprehensive analysis unless explicitly requested
- Start with essential metrics, expand only if justified

When this command is invoked:

1. **Parse the Request Document**
   - Read and analyze the stakeholder request file
   - Extract essential information:
     * The primary decision to be made
     * Required geographic scope (no more than necessary)
     * Core success criteria

2. **Intelligent Code Discovery**
   - use `pyghtcast discover` to explore the ligthcast api and find relevant data
     - read the pyghtcast cli documentation: https://github.com/Dallas-College-LMIC/pyghtcast/blob/main/CLI_DOCUMENTATION.md
   - Use `census-discover` to find relevant Census data
     - read the documentation at https://github.com/Dallas-College-LMIC/censusdis-cli/

3. **Generate Data Specification**
   Create a structured document with these sections:

   ### Executive Summary
   - Brief description of the analysis objective
   - Key questions to be answered
   - Data sources and approach

   ### Data Sources
   - **Primary Source**: Lightcast API (formerly EMSI)
   - **Datasets**: List specific datasets (e.g., EMSI.us.Occupation, EMSI.us.Industry)
   - **Secondary Sources**: Census ACS, other complementary data

   ### Target Definitions
   - **Occupation Codes**: SOC codes with descriptions
   - **Industry Codes**: NAICS codes with descriptions
   - **Geographic Scope**: MSA/FIPS codes with area names
   - **Time Period**: Analysis years and projections

   ### Data Collection Queries
   Generate queries needed to answer the specific request:
   - Analyze what data is actually required to make the decision
   - Create the minimum number of queries to fulfill the request
   - Each query should directly support the stated objective

   For each query, specify:
   - Dataset name
   - Metrics to collect
   - Constraints (area, occupation, industry filters)
   - Purpose: How this query answers part of the core request

   ### Data Processing Requirements
   - Calculations needed (location quotient, supply-demand gap, etc.)
   - Geographic comparisons
   - Trend analysis
   - Quality checks and validation

   ### Deliverable Format
   - Executive dashboard specifications
   - Detailed tables requirements
   - Visualization needs
   - Data dictionary requirements

   ### Timeline
   - Estimated data collection time
   - Analysis and processing time
   - Report preparation timeline
   - Review and quality check time

   ### Data Limitations & Considerations
   - Coverage limitations
   - Seasonal variations
   - Economic disruptions (e.g., COVID impact)
   - Self-employment considerations
   - Gig economy factors

4. **Geographic Intelligence**
   - For metro areas: Use MSA codes, suggest peer metro comparisons
   - For states: Include state and national comparisons
   - For local areas: Consider county/ZIP level data availability

5. **Quality Assurance**
   - Verify all codes exist in current data versions
   - Check geographic level compatibility
   - Ensure metric availability for specified time periods
   - Flag potential data limitations upfront

6. **Output Generation**
   - Create a descriptive name for the request based on content analysis (e.g., "personal-training-certificate-evaluation", "healthcare-workforce-analysis")
   - Extract requestor name from the document (look for signatures, contact info, "from" fields)
   - Create folder in `reports/` directory: `{YYYY-MM-DD}_{requestor-name}_{request_name}/`
   - Example: `reports/2025-01-15_thomas-b_personal-training-certificate-evaluation/`
   - Save specification as `data_spec.md` in the created folder
   - Structure document with standard sections (executive summary, data sources, queries, etc.)
   - Include working Python code examples
   - Make ready for subsequent report generation phase

## Error Handling
- If request file cannot be read, provide clear error message
- If no relevant codes can be found, suggest broader search terms
- If datasets are unavailable, suggest alternative approaches
- Validate all generated codes against actual API availability

## Integration Notes
- Uses both pyghtcast CLI and Python API
- Leverages censusdis-cli for metadata discovery
- Assumes LCAPI_USER and LCAPI_PASS environment variables are set
- Generated specifications are input for subsequent report generation commands
